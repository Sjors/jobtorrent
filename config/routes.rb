ActionController::Routing::Routes.draw do |map|
  map.resources :invoices

  #map.resources :payments

  #map.resources :jobs do |job| 
  #  job.resources :google_code_issues
  #end

  map.resources :jobs 
  map.resources :google_code_issues

  map.resource :password

  map.logout          '/logout',              :controller => 'sessions', :action => 'destroy'
  map.login           '/login',               :controller => 'sessions', :action => 'new'
  map.register        '/register',            :controller => 'users', :action => 'create'
  map.signup          '/signup',              :controller => 'users', :action => 'new'
  map.activate        '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.forgot_password '/forgot_password',      :controller => 'passwords', :action => 'new'
  map.reset_password  '/reset_password/:id',  :controller => 'passwords', :action => 'edit'
  map.fee_structure_agreement          '/fee_structure_agreement',              :controller => 'users', :action => 'fee_structure_agreement'

  map.agree_to_fee_structure  '/agree_to_fee_structure', :controller => 'users', :action => 'agree_to_fee_structure'
  
  map.resources :users, :member => { :suspend   => :put,
                                     :unsuspend => :put,
                                     :purge     => :delete } do |user|
    user.resources :roles
  end

  # '/logout' and '/login' should take precedence for RSpec to run without errors
  map.resource :session

  # "root" route needed to run RSpec stories for the the restful_authentication plugin
  map.root :controller => 'welcome',  :action => 'index'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
