require 'rails_helper'

feature 'User views latest posts' do
  scenario 'Successfuly' do
    visit posts_latest_path
  end
  
end