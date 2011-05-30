Cliftonstudios::Application.routes.draw do

  root :to => "posts#index"
  match 'news/:id' => 'posts#show'
  match 'rss.:format' => 'posts#rss'

  resources :artists, :only => [:index, :show]
  resources :posts, :only => [:index, :show]
  resources :events, :only => [:index, :show]
  resources :pictures, :only => [:index, :show]

  ['about', 'links'].each do |block|
    match block => "blocks##{block}"
  end

  resources :member_sessions, :only => [:new, :create, :destroy]
  match 'login' => "member_sessions#new", :as => :login
  match 'logout' => "member_sessions#destroy", :as => :logout
  
  resources :password_reset, :only => [:index, :create]


  namespace :members do
    resources :dashboard, :only => [:index]
    resources :password, :only => [:index, :create]
    resources :profile, :only => [:index, :create]
    resources :contact_list, :only => [:index]
    resources :executive, :only => [:index, :create]
    resources :links, :except => [:show]
    resources :posts, :except => [:show]
    
    ['bylaws', 'emails'].each do |block|
      match block => "blocks##{block}"
    end
  end
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
