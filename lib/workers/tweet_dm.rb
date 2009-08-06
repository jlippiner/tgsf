class TweetDm
  
  def main(username,password)
    begin
      twitter = Twitter::Client.new(:login => username, :password => password)
      dm_post = "Hey. Check this out - http://EndSMA.org/twitter. Pretty cool way to help fight this disease."
      followers = twitter.my(:followers)
      followers.each do |follower|
        twitter.message(:post, dm_post, follower)
      end
    rescue Exception => e
        HoptoadNotifier.notify(:error_message => e)
    end
  end
  
end