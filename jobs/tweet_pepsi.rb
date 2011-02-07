require 'open-uri'
require 'json'

class TweetPepsi

  def initialize()
    audit_logfile = File.open("#{RAILS_ROOT}/log/tweet_search.log", 'a')
    audit_logfile.sync = true
    @ts_log = AuditLogger.new(audit_logfile)
    dwrite 'INITIALIZING TweetPepsi v2!'
  end

  def perform
    refresh_searches('tag=#pepsirefresh','pepsi_v2')
    
    endsmadotcom = User.find_by_login('EndSMAdotcom')
    voteforacure = User.find_by_login('voteforacure')

    dwrite("TweetPepsi: sending from endsmadotcom")
    # send_replies(endsmadotcom,'pepsi_v2')

    dwrite("TweetPepsi: sending from voteforacure")
    # send_replies(voteforacure,'pepsi_v2')
  end

  def send_replies(user,tag)
    if user && Search.by_tag(tag).available.count > 0
      user.twitter.get('/account/verify_credentials')
      dwrite("TweetPepsi: #{Search.available.count} searches available for tag: #{tag}")
      searches = Search.by_tag(tag).available.find(:all, :limit => 200)
      searches.each {|x| x.update_attribute(:in_process, true) }

      searches.each_with_index do |search,ndx|
        begin
          user.twitter.post('/statuses/update.json', 'status' => "@#{search.from_user} I just did! Can you also vote to help this mom win $5,000 to save her baby, cure a disease. http://bit.ly/bV99Ei", 'in_reply_to_status_id' => search.status_id)
          dwrite("TweetPepsi: [#{ndx}] reached out to #{search.from_user} with message from #{user.login} for tag: #{tag}")
          search.update_attribute(:user, user)
        rescue Exception => e
          dwrite("** TweetPepsi: #{e.message}.")
        end
      end
    else
      dwrite("** TweetPepsi: user not found") unless user
      dwrite("** TweetPepsi: not searches available") if Search.by_tag(tag).available.empty?
    end
  end

  def refresh_searches(query,tag)
    # get the latest chase giving mentions and store in database without a user
    # Get a list of all status_ids to contact
    max_posted_at = Search.by_tag(tag).maximum(:posted_at)
    max_posted_at ||= Date.new(y=2011, m=01, d=15)
    1.upto(15) do |page_number|
      dwrite("TweetPepsi: Retrieving tweets from page #{page_number} for #{query}")
      tweets = twitter_search(query, page_number, max_posted_at.strftime('%Y-%m-%d'))

      return false unless tweets
      return true if tweets["results"].count == 0

      tweets["results"].each do |tweet|
        status_id = tweet['id']
        from_user = tweet['from_user']
        from_user_id = tweet['from_user_id']
        message = tweet['text']
        posted_at = tweet['created_at']

        search = Search.create(:status_id => status_id, :from_user => from_user, :from_user_id => from_user_id, :message => message, :tag => tag, :posted_at => posted_at)
      end if tweets["results"]

      dwrite("TweetPepsi: #{tweets["results"].count} new tweets found")
    end

    true
  end

  def twitter_search(query, page_number=1,since_id=1,number_to_fetch=100)
    begin
      JSON.parse(open("http://search.twitter.com/search.json?#{query}&since=#{since_id}&rpp=#{number_to_fetch}&page=#{page_number}").read)
    rescue Exception => e
      nil
    end
  end

  def dwrite(msg)
    puts msg
    @ts_log.info msg
  end
end

def main
  ts = TweetPepsi.new
  ts.perform
end

main
