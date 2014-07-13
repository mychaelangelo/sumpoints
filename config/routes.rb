Rails.application.routes.draw do
  
  devise_for :users
  # App always needs a root path to work on Heroku
  # this will be the default page for the app
  root to: 'welcome#index'
  get 'about' => 'welcome#about'

  get '/articles' => 'formats#articles'
  get '/books' => 'formats#books'
  get '/videos' => 'formats#videos'
  get '/audio' => 'formats#audio'

  # Paths for tags
  get 'tags/:tag' => 'welcome#index', as: :tag

  # routes for posts (index, show, new, edit)
  resources :posts do
    # post vote routes
    get '/up-postvote' => 'postvotes#up_postvote', as: :up_postvote
    get '/down-postvote' => 'postvotes#down_postvote', as: :down_postvote

    # following a post
    resources :followedposts, only: [:create, :destroy]
  end

  # paths for users
  resources :users, only: [:update]



end
