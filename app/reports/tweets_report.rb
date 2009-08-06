class TweetsReport < DynamicReports::Report
  title "Tweets Report"
  sub_title "All those that have tweeted for a cure"
  columns :zipcode, :twitter_id, :sent_dm, :is_following, {:number_of_friends => "# of friends"}, {:number_of_followers => '# of followers'}, {:created_at => "Date"}
  
end