ActionController::Routing::Routes.draw do |map|
  map.connect 'users/index_old', :controller => 'users', :action => 'index_old', :conditions => {:method => :get}
  map.resources :users, :has_many => :guesses

  # The priority is based upon order of creation: first created -> highest priority.

  map.connect 'accounts/claim', :controller => 'account', :action => 'claim', :conditions => {:method => :post}
  map.connect 'accounts/signup', :controller => 'account', :action => 'signup'
  map.connect 'user/edit', :controller => 'users', :action => 'edit'
  map.connect 'watchers', :controller => 'watchers', :action => 'create', :conditions => {:method => :post}
  map.connect 'watchers/:id', :controller => 'watchers', :action => 'destroy', :conditions => {:method => :delete}

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

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
   map.root :controller => "account"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action'
end
