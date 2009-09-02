ActionController::Routing::Routes.draw do |map|

  map.with_options(:controller => "questions", :name_prefix => "question_") do |question|
    question.connect 'questions/admin_view',  :action => "admin_view"
    question.survey 'questions/show/:userid/:step', :action => "survey", :controller => "questions"
    question.answer "questions/show/:userid/:version/:step/:questionid", :action => "record_answer", :controller => "questions"
    map.resources :questions
  end

  map.with_options(:controller => "twitter", :name_prefix => "twitter_") do |twitter|
    twitter.tweet 'twitter/tweet', :action => 'tweet'
    twitter.tweetit 'twitter/tweet/send', :action => 'tweetit'
    twitter.thankyou 'twitter/thankyou', :action => 'thankyou'
    twitter.connect 'twitter/admin_view', :action => 'admin_view' 
    twitter.connect 'twitter/oauth', :action => 'oauth' 
    map.resources :twitter
  end

  map.with_options(:controller => "pages", :name_prefix => "page_") do |page|
    pages = %w(donation gallery our_story about_sma get_involved press contact_us newly_diagnosed gallery what_we_do awareness support research about_gwendolyn testing)
    pages.each {|p|
      page.send(p.intern, "#{p}", :action => "#{p}", :controller => "pages")
    }
  end

  map.connect 'users/admin_view', :action => "admin_view", :controller => "users"
  
  map.resources :users
  map.resources :answers
  map.resources :donations
  map.resources :presses
  map.resources :unites
  map.resources :unite_donations
  map.resources :uftc
  
  map.root :controller => "pages"
end
