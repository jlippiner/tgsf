class TweetProcess

  def main(params,tweet_id)
    begin
      get_members(params[:zipcode])
      username = params[:username]
      password = params[:password]
      
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

      # Get their profile pic
      profile_pic_url = twitter.my(:info).profile_image_url if params[:add_to_wall]

      # Add them as a follower
      twitter.friend(:add, 'EndSMAdotcom') unless twitter.my(:friends).detect {|x| x.screen_name == 'EndSMAdotcom'} if params[:follow]

      # DM their friends if selected
      if params[:dm]
        dm_post = "Hey. Check this out - http://EndSMA.org/twitter. Pretty cool way to help fight this disease."
        followers = twitter.my(:followers)
        followers.each do |follower|
          twitter.message(:post, dm_post, follower)
        end
      end

      # Log what happened
      tweet = Tweet.find_by_id(tweet_id) if tweet_id
      tweet.update_attributes({:twitter_id => username, :is_following => !params[:follow].nil?, :profile_pic_url => profile_pic_url,
      :sent_dm => !params[:dm].nil?, :number_of_friends => twitter.my(:friends).size, :number_of_followers => twitter.my(:followers).size}) if tweet

    rescue Exception => e
      Rails.logger.debug(e.to_s)
      HoptoadNotifier.notify(:error_message => e)
    end
  end
  
  def get_members(zip)
    Sunlight::Base.api_key = '160a62531299fec8f90bc2f894526d8f'
    @members_of_congress = Sunlight::Legislator.all_in_zipcode(zip)
  end

end
