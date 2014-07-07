Rails.application.routes.draw do
  
  # App always needs a root path to work on Heroku
  # this will be the default page for the app
  root to: 'welcome#index'

  get 'welcome/index'
  get 'welcome/about'
end
