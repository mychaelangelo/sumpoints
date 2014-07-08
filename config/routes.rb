Rails.application.routes.draw do
  
  # App always needs a root path to work on Heroku
  # this will be the default page for the app
  root to: 'welcome#index'
  get 'about' => 'welcome#about'

  # routes for posts (index, show, new, edit)
  resources :posts

end
