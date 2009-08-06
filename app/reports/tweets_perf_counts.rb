class TweetsPerfCounts < DynamicReports::Report
  title "Tweets Performance Report"
  sub_title "Total starts and completes"
  columns :not_done, :done
  
end