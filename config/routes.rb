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

    # following a post
    resources :followedposts, only: [:create, :destroy]

    # Sumpoints are nested under posts i.e. /posts/sumpoints
    resources :sumpoints do
      resources :likes, only: [:create, :destroy]
    end
  end

  # paths for users
  resources :users, only: [:update]

  # routes for sumpoints
  resources :sumpoints

  # for user bookmarks
  get "/users/my_likes"
  get "users/my_follows"

end
