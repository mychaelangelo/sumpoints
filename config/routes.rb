Rails.application.routes.draw do
  

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  # App always needs a root path to work on Heroku
  # this will be the default page for the app
  root to: 'welcome#index'
  get 'about' => 'welcome#about'

  get 'sumpoints/index'

  # Path to view latest posts
  get "posts/latest" => "posts#latest"



  # Paths for tags
  get 'tags/:tag' => 'welcome#index', as: :tag

  # routes for posts (index, show, new, edit)
  resources :posts do
    # post vote routes
    get '/up-postvote' => 'postvotes#up_postvote', as: :up_postvote
    get '/down-postvote' => 'postvotes#down_postvote', as: :down_postvote

    # following a post
    resources :followedposts, only: [:create, :destroy]

    resources :sumpoints do
      get '/up-like' => 'likes#up_like', as: :up_like
      get '/down-like' => 'likes#down_like', as: :down_like
    end


  end

  # paths for users
  resources :users, only: [:update]

  # routes for sumpoints
  resources :sumpoints



end
