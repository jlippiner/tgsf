ActionController::Routing::Routes.draw do |map|
  map.resources :presses

  map.resources :presses

  map.resources :donations

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
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


  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.root :controller => "pages"
end
