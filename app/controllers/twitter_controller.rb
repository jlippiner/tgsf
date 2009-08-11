require 'sunlight'

class TwitterController < ApplicationController
  layout 'twitter'
  before_filter :login_required, :only => [:oauth]

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
    render :tweet
  end

  def tweetit
    tweet = Tweet.find_by_id(session[:tweet_id])
    tweet.update_attributes({:is_following => !params[:follow].nil?, :sent_dm => !params[:dm].nil?}) if tweet
    redirect_to :action => "oauth"
  end

  def oauth
    if current_user
      Job.enqueue!(TweetProcess,:main,current_user.login,session[:tweet_id])

      # Redirect
      thankyou
    else
      tweet = Tweet.find_by_id(tweet_id) if tweet_id
      get_members(tweet.zipcode)
      render :tweet
    end
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
