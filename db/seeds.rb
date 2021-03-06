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
  post = Post.create(
    user: users.sample,
    title: Faker::Lorem.sentence,
    url: Faker::Internet.url,
    tag_list: [Faker::Lorem.word, Faker::Lorem.word, Faker::Lorem.word]
  )
  # set the created_at to a time within the past year
  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
end
posts = Post.all

# Create Sumpoints
100.times do
  sumpoint = Sumpoint.create(
    post: posts.sample,
    user: users.sample,
    body: Faker::Lorem.sentence,
    tag_list: [Faker::Lorem.word, Faker::Lorem.word, Faker::Lorem.word]
  )
  sumpoint.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  sumpoint.update_rank
end

# Create an admin user
 admin = User.new(
   name:     'Admin User',
   email:    'admin@example.com',
   password: 'password',
   role:     'admin'
 )
 admin.skip_confirmation!
 admin.save
 
 # Create a moderator
 moderator = User.new(
   name:     'Moderator User',
   email:    'moderator@example.com', 
   password: 'helloworld',
   role:     'moderator'
 )
 moderator.skip_confirmation!
 moderator.save
 
 # Create a member
 member = User.new(
   name:     'Member User',
   email:    'member@example.com',
   password: 'helloworld',
 )
 member.skip_confirmation!
 member.save



puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Sumpoint.count} sumpoints created"