require 'sunlight'

class TwitterController < ApplicationController
  layout 'twitter'

  def show
    render :index
  end

  def index
    render :index
  end

  def create
    if zipcode_valid(params[:zipcode])
      get_members(params[:zipcode])
      if @members_of_congress.empty?
        flash.error = "We could not find any reps for that zipcode.  Please double check and try again."
        index
      else
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
      begin
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

        # Update their status
        status_post = "I just took 30 seconds to help END #SMA, the #1 genetic killer of young children. Go to http://EndSMA.org/twitter to tweet for a cure!"
        twitter.status(:post, status_post)

        # Add them as a follower
        twitter.friend(:add, 'EndSMAdotcom') unless twitter.my(:friends).detect {|x| x.screen_name == 'EndSMAdotcom'} if params[:follow]

        # DM their friends if selected
        Job.enqueue!(TweetDm,:main,username,password) if params[:dm]

        # Log what happened
        Tweet.create({:zipcode => params[:zipcode],
          :twitter_id => username, :is_following => !params[:follow].nil?,
        :sent_dm => !params[:dm].nil?, :number_of_friends => twitter.my(:friends).size, :number_of_followers => twitter.my(:followers).size})

        # Redirect
        thankyou

      rescue Exception => e
        flash.error = "We could not authenticate that username and password.  Please try again"
        render :tweet
      end
    end
  end

  def thankyou
    flash.clear
    render :thankyou
  end

  def admin_view
      @tweets = Tweet.find(:all, :order => "created_at DESC")
      @daily_reach = Tweet.find(:all, :select => "DATE_FORMAT(created_at,'%d/%m/%Y') 'date', SUM(number_of_friends) +  SUM(number_of_followers) as reach",
                                    :group => "DATE_FORMAT(created_at,'%d/%m/%Y')")
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
