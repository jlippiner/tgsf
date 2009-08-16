def main
  STDIN.each do |arg|
    dwrite("Twitter Process: Oauth - STARTING PROCESS OF TWEET at #{Time.now} for Tweet ID : #{arg}")

    tweet = Tweet.find_by_id(arg) if arg
    user = User.find_by_login(tweet.twitter_id) if tweet

    if user && tweet
      login = tweet.twitter_id

      get_members(tweet.zipcode)
      dwrite("Twitter (#{login}): Retrieved members from API")

      user.twitter.get('/account/verify_credentials')
      dwrite("Twitter (#{login}): Logged in successful")

      # Log what happened
      tweet.update_attributes({:twitter_id => login, :profile_pic_url => user.profile_image_url,
      :number_of_friends => user.friends_count , :number_of_followers => user.followers_count}) if tweet

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

        user.twitter.post('/statuses/update.json', 'status' => rep_post)
      end
      dwrite("Twitter (#{login}): Posted messages to reps!")

      # Update their status
      status_post = "I just took 30 seconds to help END #SMA, the #1 genetic killer of young children. Go to http://EndSMA.org/twitter to tweet for a cure!"
      user.twitter.post('/statuses/update.json', 'status' => status_post)
      dwrite("Twitter (#{login}): updated status for user ")

      # DM their friends if selected
      if tweet.sent_dm && user.followers_count > 0
        dm_post = "Just wanted to let you know I did this to help with this cause - http://EndSMA.org/twitter."
        prev_followers = Follower.all.map {|x| x.screen_name}

        1.upto(user.followers_count / 100 + 1) do |page_num|
          followers = user.twitter.get("/statuses/followers.json?screen_name=#{login}&page=#{page_num}")
          their_followers = followers.map {|x| x['screen_name']}
          new_followers = their_followers - prev_followers

          new_followers.each do |follower|
            Follower.create({:screen_name => follower, :friend_id => user.twitter_id})
            user.twitter.post('/direct_messages/new.json', 'screen_name' => follower, 'text' => dm_post)
          end
          dwrite("Twitter (#{login}): Successfully sent DMs to #{followers.size} followers out of #{user.followers_count} (Page: #{page_num})")
        end

      end

      # Add them as a follower and catch error in case they are already following
      begin
        user.twitter.post("/friendships/create.json?screen_name=EndSMAdotCOM")
        dwrite("Twitter (#{login}): Added EndSMAdotCom as friend") if tweet.is_following
      rescue Exception => e
        dwrite("Twitter Friend Add Error: #{e.to_s}")
      end

      #Log completed
      tweet.update_attributes({:completed => true}) if tweet
      dwrite("Twitter (#{login}): Recorded completed as true")

      true
    end
  end

rescue Exception => e
  dwrite("Twitter Error: #{e.to_s}")
  HoptoadNotifier.notify(:error_message => e)
end

def get_members(zip)
  Sunlight::Base.api_key = '160a62531299fec8f90bc2f894526d8f'
  @members_of_congress = Sunlight::Legislator.all_in_zipcode(zip)
end

def dwrite(msg)
  puts msg
  Rails.logger.info("==> #{msg}")
end



#run it
main
