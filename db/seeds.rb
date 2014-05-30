# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sr = User.create(username: "Support Robot", password: Faker::Internet.password)
creator = User.create(username: "The Creator", password: Faker::Internet.password)

users = []
forums = []

25.times do
  begin
    name = Faker::Internet.user_name
    password = Faker::Internet.password
    users.push(User.create(username: name, password: password, password_confirmation: password))
  rescue
  retry
  end
end

main = Section.create!(name: "Main", rank: 1)
discussion = Section.create!(name: "Discussion", rank: 2)
arts = Section.create!(name: "The Finer Arts", rank: 3)
community = Section.create!(name: "Community", rank: 4)



forums << gc = main.forums.create!(name: "General Crap", rank: 1)
forums << main.forums.create!(name: "BYOB", rank: 2)

forums << sscs = discussion.forums.create!(name: "Super Serious Computer Stuff", rank: 1)
forums << discussion.forums.create!(name: "Games", rank: 2)
forums << discussion.forums.create!(name: "Gadgets", rank: 3)
forums << discussion.forums.create!(name: "Ask / Tell", rank: 4)
forums << discussion.forums.create!(name: "Debate & Discussion", rank: 5)
forums << discussion.forums.create!(name: "Silver Spoon", rank: 6)
forums << discussion.forums.create!(name: "Post Your Favorite", rank: 7)
forums << discussion.forums.create!(name: "Super Serious Computer Stuff", rank: 8)

forums << arts.forums.create!(name: "Cinema Discussion", rank: 1)
forums << arts.forums.create!(name: "The TV IV", rank: 2)
forums << arts.forums.create!(name: "Books Books Books", rank: 3)
forums << arts.forums.create!(name: "We Don't Discuss Music", rank: 4)
forums << arts.forums.create!(name: "Comics and Stuff Without Words", rank: 5)


forums << sf = community.forums.create!(name: "San Francisco", rank: 2)

(1..26).each do |i|
  user = users.sample
  thread = gc.post_threads.create!(title: Faker::Lorem.sentence, user: user)
  thread.posts.create!(body: Faker::Lorem.paragraph, user: user)
  (1..300).to_a.sample.times do
    thread.posts.create!(body: Faker::Lorem.paragraphs((1..6).to_a.sample).join("\n\n"), user: users.sample)
  end
end

sleep 2

forums.each do |forum|
  thread = forum.post_threads.create!(title: "Welcome to the Something Awesome Forums!", user: sr)
  thread.posts.create!(body: "Welcome to the forums!\n\nTo make threads and posts as well as gain access to other features you must be logged-in.  Please click the \"Sign Up\" button in the top-right if you do not already have an account.\n\n Thanks for visiting!", user: sr)
end