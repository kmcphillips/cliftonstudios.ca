Cliftonstudios::Application.routes.draw do

  get "contact_executive/create"
  get "contact_executive/index"

  root to: "posts#index"
  get 'news/:id' => 'posts#show'
  get 'rss.:format' => 'posts#rss'

  resources :artists, only: [:index, :show]
  resources :posts, only: [:index, :show]
  resources :events, only: [:index, :show]
  resources :pictures, only: [:index, :show]

  ['about', 'contact', 'links', 'search'].each do |block|
    get block => "blocks##{block}"
  end

  resources :member_sessions, only: [:new, :create, :destroy]
  get 'login' => "member_sessions#new", as: :login
  get 'logout' => "member_sessions#destroy", as: :logout

  resources :unsubscribe, only: [:show, :update]
  resources :password_reset, only: [:index, :create, :show]
  resources :mailing_list, only: [:create]

  namespace :members do
    resources :dashboard
    resources :password, only: [:index, :create]
    resources :profile, only: [:index, :create]
    resources :executive, only: [:index, :create]
    resources :links, except: [:show] do
      collection do
        post :sort
      end
    end
    resources :posts, except: [:show]
    resources :events, except: [:show]
    resources :blocks, only: [:index, :create]
    resources :members, except: [:destroy] do
      member do
        post 'password_reset'
      end
    end
    resources :pictures, only: [:index, :create, :update, :destroy, :edit] do
      collection do
        get 'all'
      end
    end
    resources :contact_list, only: [:index] do
      collection do
        get 'print'
      end
    end
    resources :mailing_list, only: [:index, :update, :create] do
      collection do
        post 'bulk_create'
      end
    end
    resources :contact_executive, only: [:index, :create]
    resources :system_variables, only: [:index, :update]
    resources :minutes, only: [:index, :create, :destroy]
    resources :bylaws, only: [:index, :new, :edit, :create, :update, :destroy]

    ['emails', 'mail_queue', 'audits'].each do |block|
      get block => "blocks##{block}"
    end
  end

  ## Legacy PHP URLs
  %w[news events about artists pictures login].each do |page|
    get "#{page}.php" => "legacy_routes##{page}"
  end

  # Catch all remaining PHP pages and send them somewhere
  get ":page.php" => "legacy_routes#default"

end
