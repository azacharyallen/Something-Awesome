# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sr = User.create!(username: "Support Robot", password: Faker::Internet.password)

users = []

50.times do
  begin
    name = Faker::Internet.user_name
    password = Faker::Internet.password
    users.push(User.create!(username: name, password: password, password_confirmation: password))
  rescue
  retry
  end
end

main = Section.create!(name: "Main", rank: 1)
discussion = Section.create!(name: "Discussion", rank: 2)

gc = main.forums.create!(name: "General Crap", rank: 1)
sscs = discussion.forums.create!(name: "Super Serious Computer Stuff", rank: 1)
sf = discussion.forums.create!(name: "San Francisco", rank: 2)

(1..26).each do |i|
  user = users.sample
  thread = gc.post_threads.create!(title: Faker::Lorem.sentence, user: user)
  thread.posts.create!(body: Faker::Lorem.paragraph, user: user)
  (1..300).to_a.sample.times do
    thread.posts.create!(body: Faker::Lorem.paragraphs((1..6).to_a.sample).join("\n\n"), user: users.sample)
  end
end

(1..10).each do |i|
  user = users.sample
  thread = sscs.post_threads.create!(title: Faker::Lorem.sentence, user: user)
  thread.posts.create!(body: Faker::Lorem.paragraph, user: user)
  (1..42).to_a.sample.times do
    thread.posts.create!(body: Faker::Lorem.paragraphs((1..6).to_a.sample).join("\n\n"), user: users.sample)
  end
end