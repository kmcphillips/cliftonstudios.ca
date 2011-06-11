Cliftonstudios::Application.routes.draw do

  root :to => "posts#index"
  match 'news/:id' => 'posts#show'
  match 'rss.:format' => 'posts#rss'

  resources :artists, :only => [:index, :show]
  resources :posts, :only => [:index, :show]
  resources :events, :only => [:index, :show]
  resources :pictures, :only => [:index, :show]

  ['about', 'links', 'search'].each do |block|
    match block => "blocks##{block}"
  end

  resources :member_sessions, :only => [:new, :create, :destroy]
  match 'login' => "member_sessions#new", :as => :login
  match 'logout' => "member_sessions#destroy", :as => :logout
  
  resources :unsubscribe, :only => [:show, :update]
  resources :password_reset, :only => [:index, :create]

  namespace :members do
    resources :dashboard
    resources :password, :only => [:index, :create]
    resources :profile, :only => [:index, :create]
    resources :executive, :only => [:index, :create]
    resources :links, :except => [:show]
    resources :posts, :except => [:show]
    resources :events, :except => [:show]
    resources :blocks, :only => [:index, :create]
    resources :members, :except => [:destroy]

    resources :pictures, :only => [:index, :create, :update, :destroy] do
      collection do
        get 'all'
      end
    end

    resources :contact_list, :only => [:index] do
      collection do
        get 'print'
      end
    end

    ['bylaws', 'emails', 'mail_queue'].each do |block|
      match block => "blocks##{block}"
    end
  end

  ## Legacy PHP URLs
  %w[news events about artists pictures login].each do |page|
    match "#{page}.php" => "legacy_routes##{page}"
  end

  # Catch all remaining PHP pages and send them somewhere
  match ":page.php" => "legacy_routes#default"

end
