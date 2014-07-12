# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

# Create Users
5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save
end
users = User.all


# Create Posts
50.times do
  Post.create(
    user: users.sample,
    title: Faker::Lorem.sentence,
    url: Faker::Internet.url
    # will need to set type: also!
  )
end
posts = Post.all

# Create Sumpoints
100.times do
  Sumpoint.create(
    post: posts.sample,
    body: Faker::Lorem.sentence
  )
end

# Create an admin user
admin = User.new(
  name: 'Michael',
  email: 'admin@example.com',
  password: 'password',
  )
admin.skip_confirmation!
admin.save



puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Sumpoint.count} sumpoints created"