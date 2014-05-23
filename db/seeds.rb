# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sa1 = User.create!(username: "Someone Awesome 1", email: "blah@somewhere.com", password: "password", password_confirmation: "password", avatar: "default_avatar.png")
sa2 = User.create!(username: "Someone Awesome 2", email: "blah@somewhere.com", password: "password", password_confirmation: "password", avatar: "default_avatar2.png")


main = Section.create!(name: "Main", rank: 1)
discussion = Section.create!(name: "Discussion", rank: 2)

gc = main.forums.create!(name: "General Crap", rank: 1)
sscs = discussion.forums.create!(name: "Super Serious Computer Stuff", rank: 1)
sf = discussion.forums.create!(name: "San Francisco", rank: 2)

