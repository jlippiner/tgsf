class TweetsReport < DynamicReports::Report
  title "Tweets Report"
  sub_title "All those that have tweeted for a cure"
  columns :zipcode, {:twitter_id => 'Twitter'}, {:sent_dm => "Sent DM?"}, {:is_following => "Following EndSMAdotcom?"}, {:number_of_friends => "# of friends"}, {:number_of_followers => '# of followers'}, :completed, {:created_at => "Date"}
  
end