require_relative 'data/genres_data.rb'
require_relative 'data/prefectures_data.rb'
require_relative 'data/rulebooks_data.rb'

require 'database_cleaner/active_record'
require 'faker'

puts "Clearing out the battlefield 🌋..."
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean
puts "Battlefield Cleared ⛰"

puts "Summoning Gandalf 🧙🏻‍♂️"
gandalf = User.create!(
  email: 'gandalf@gmail.com',
  nickname: 'GandalfTheWhite',
  password: '123456',
  city: "#{WARDS.sample}-ku, Tokyo"
  )
puts "#{gandalf.nickname} Summoned: 'You Shall Not Pass!' 🧖🏼‍♂️"

puts "Generating NPCs..."
40.times do
  i = 0
  user = User.create(
    email: Faker::Internet.email,
    nickname: Faker::Internet.username,
    password: '123456',
    city: "#{i += 1}. #{WARDS.sample}-ku, Tokyo"
    )
  puts "#{user.nickname} - #{user.city} created"
end
puts "All NPCs Generated"

puts "Generating Groups..."
Group.create(
  name: Faker::App.name,
  description: Faker::Company.bs,
  city: "#{WARDS.sample}-ku, Tokyo",
  gm: gandalf
  )

20.times do
  i = 0
  group = Group.create(
    name: Faker::App.name,
    description: Faker::Company.bs,
    city: "#{WARDS.sample}-ku, Tokyo",
    gm: User.all.sample
    )
  puts "#{i += 1}. #{group.name} created"
end
puts "All Groups Created"

puts "Linking Users to Groups..."
3.times do
    group = Group.all.sample
    group = Group.all.sample if group.gm == gandalf
    PlayerGroup.create(
      user: gandalf,
      group: group
    )
end

30.times do
  user = User.all.sample
  group = Group.all.sample
  group = Group.all.sample if group.gm == user
  group = Group.all.sample if group.users.count == 5
  p_group = PlayerGroup.create(
    user: user,
    group: group
    )
end
puts "We have Player Groups 🕺"

puts "Generating Genres..."
RPG_GENRES.each_key do |genre|
  i = 0
  rpg = Genre.create(
    name: RPG_GENRES[genre][:title],
    description: RPG_GENRES[genre][:description]
    )
  puts "#{i += 1}. #{rpg.name} created"
end
puts "Genres Created 🔠"

puts "Deciding what Users prefer..."

Preference.create(
  user: gandalf,
  genre: Genre.all.sample
  )

50.times do
  Preference.create(
    user: User.all.sample,
    genre: Genre.all.sample
    )
end
puts "They decided"
