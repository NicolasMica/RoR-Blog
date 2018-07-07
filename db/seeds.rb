# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

users = Array.new
posts = Array.new

for i in 1..6
  user = User.create! do |user|
    user.firstname = Faker::Name.first_name
    user.lastname = Faker::Name.last_name
    user.email = Faker::Internet.email
    user.password = 'secret'
    user.password_confirmation = 'secret'
  end

  users.push(user)
end

users.each do |user|
  rand(2..8).times do
    post = Post.create! do |post|
      post.name = Faker::Lorem.sentence(1, false, 3)
      post.heading = Faker::Lorem.paragraph(3, true, 4)
      post.content = Faker::Lorem.paragraph(8, true, 16)
      post.remote_image_url = 'http://picsum.photos/1280/720/?' + rand(1..9999).to_s
      post.user = user
      post.created_at = Faker::Date.between(2.years.ago, Date.today)
    end

    posts.push(post)
  end
end

posts.each do |post|
  rand(0..12).times do
    Comment.create! do |comment|
      comment.content = Faker::Lorem.paragraph(1, true, 4)
      comment.post = post
      comment.user = users.sample
      comment.created_at = Faker::Date.between(post.created_at, Date.today)
    end
  end
end
