ActionController::Routing::Routes.draw do |map|
	# map.resources :tags do |tags|
	# 	tags.resources :posts, :only => [:index]
	# end
	
	map.post_permalink ':year/:month/:day/:id', :controller => 'posts', :action => 'show',
			:requirements => { :year => /(19|20)\d\d/, :month => /[01]?\d/, :day => /[0-3]?\d/ },
			:month => nil, :day => nil, :id => nil, :method => :get
  map.resources :posts do |post|
		post.resources :comments, :shallow => true
		post.resources :file_uploads, :as => 'photos', :shallow => true
	end
	
  map.resources :file_uploads, :as => 'photos'

	map.resources :sessions

	map.login		':terminology',	:controller => 'sessions', :action => 'new', :terminology => /login|admin/
	map.logout	'logout', 			:controller => 'sessions', :action => 'destroy'
	
	map.home '',	:controller => 'posts'
  map.root			:controller => 'posts'
end
