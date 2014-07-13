require 'rails_helper'

feature 'User creates Post' do
  scenario 'Successfuly' do
    visit new_post_path
  end
  
end