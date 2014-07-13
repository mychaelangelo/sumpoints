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
  resources :posts

  # paths for users
  resources :users, only: [:update]

end
