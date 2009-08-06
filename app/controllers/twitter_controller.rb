require 'sunlight'

class TwitterController < ApplicationController
  layout 'twitter'

  def show
    render :index
  end

  def index
    @profile_pics = Tweet.find(:all, :conditions => "profile_pic_url is not null").collect {|x| x.profile_pic_url}
    render :index
  end

  def create
    if zipcode_valid(params[:zipcode])
      get_members(params[:zipcode])
      if @members_of_congress.empty?
        flash.error = "We could not find any reps for that zipcode.  Please double check and try again."
        index
      else
        # Create record
        unless session[:tweet_id]
          tweet = Tweet.create({:zipcode => params[:zipcode]})
          session[:tweet_id] = tweet.id
        end

        flash.clear
        render :tweet
      end
    else
      flash.error = "Please enter a valid US zip code"
      index
    end

  end

  def tweet
  end

  def tweetit
    get_members(params[:zipcode])
    username = params[:username]
    password = params[:password]
    
    if (username.blank? || password.blank?)
      flash.error = "Please enter your twitter username/email and password."
      render :tweet
    else
      client = Twitter::Client.new
      if client.authenticate?(username, password)
        twitter = Twitter::Client.new(:login => username, :password => password)

        # Post messages to reps
        @members_of_congress.each do |rep|
          rep_post = "It is important to me that you cosponsor the #SMATreatmentAccelerationAct"
          rep_post = "@#{rep.twitter_id}: #{rep_post}" unless rep.twitter_id.blank?
          rep_post = "\##{rep.title}#{rep.firstname}#{rep.lastname}: #{rep_post}" if rep.twitter_id.blank?
          if (rep.title == "Rep")
            rep_post = rep_post + ", H.R. 2149! http://bit.ly/1W0Lr"
          else
            rep_post = rep_post + ", S. 1158! http://bit.ly/aml9l"
          end
          twitter.status(:post, rep_post)
        end
gi
        # Update their status
        status_post = "I just took 30 seconds to help END #SMA, the #1 genetic killer of young children. Go to http://EndSMA.org/twitter to tweet for a cure!"
        twitter.status(:post, status_post)
        
        # Get their profile pic
        profile_pic_url = twitter.my(:info).profile_image_url if params[:add_to_wall]

        # Add them as a follower
        twitter.friend(:add, 'EndSMAdotcom') unless twitter.my(:friends).detect {|x| x.screen_name == 'EndSMAdotcom'} if params[:follow]

        # DM their friends if selected
        Job.enqueue!(TweetDm,:main,username,password) if params[:dm]

        # Log what happened
        tweet = Tweet.find_by_id(session[:tweet_id])
        tweet.update_attributes({:twitter_id => username, :is_following => !params[:follow].nil?, :profile_pic_url => profile_pic_url,  
        :sent_dm => !params[:dm].nil?, :number_of_friends => twitter.my(:friends).size, :number_of_followers => twitter.my(:followers).size}) if tweet

        # Redirect
        thankyou
      else
        flash.error = "We could not authenticate that username and password.  Please try again"
        render :tweet
      end
    end

  rescue Exception => e
    flash.error = "Something went wrong with Twitter.  Please try back in a few minutes.  We have been notified of the problem"
    notify_hoptoad e
    render :tweet
  end

  def thankyou
    flash.clear
    render :thankyou
  end

  def admin_view
    @tweets = Tweet.find(:all, :conditions => 'twitter_id IS NOT null', :order => "created_at DESC")
    @daily_reach = Tweet.find(:all, :select => "DATE_FORMAT(created_at,'%m/%d/%Y') 'date', SUM(number_of_friends) +  SUM(number_of_followers) as reach", :group => "DATE_FORMAT(created_at,'%m/%d/%Y')")

    count_not_done = Tweet.count(:conditions => 'twitter_id IS null')
    count_done = Tweet.count(:conditions => 'twitter_id IS NOT null')
    @counts = [{:not_done => count_not_done, :done => count_done}]


  end

  private

  def get_members(zip)
    Sunlight::Base.api_key = '160a62531299fec8f90bc2f894526d8f'
    @members_of_congress = Sunlight::Legislator.all_in_zipcode(zip)
  end

  def zipcode_valid(zip)
    zip =~ /^\d{5}([\-]\d{4})?$/
  end
end
