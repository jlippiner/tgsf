class TweetDailyReach < DynamicReports::Report
  title "Tweets Daily Reach"
  sub_title "Followers + Friends of all those that have tweeted daily"
  columns :date, :reach
  
  chart :daily_reach do
    columns :reach
  end
end