# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

# Create Posts
50.times do
  Post.create(
    title: Faker::Lorem.sentence,
    url: Faker::Internet.url
  )
end
posts = Post.all

# Create sumpoints
100.times do
  Sumpoint.create(
    post: posts.sample,
    body: Faker::Lorem.sentence
  )
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Sumpoint.count} sumpoints created"