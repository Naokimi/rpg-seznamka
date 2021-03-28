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
  city: 'Shibuya-ku, Tokyo'
  )
puts "#{gandalf.nickname} Summoned: 'You Shall Not Pass!' 🧖🏼‍♂️"

puts "Generating NPCs..."

40.times do
  prefecture = PREFECTURES.sample

  city = if prefecture[:prefecture] == 'Tokyo'
          city_or_ward = prefecture.keys[rand(2..3)]
          city_or_ward == :ward ? "#{prefecture[city_or_ward].sample}-ku" : "#{prefecture[city_or_ward].sample}-shi"
          else
            "#{prefecture[:city].sample}-shi"
         end

  user = User.create(
    email: Faker::Internet.email,
    nickname: Faker::Internet.username,
    password: '123456',
    city: "#{city}, #{prefecture[:prefecture]}"
    )
  puts "#{user.nickname} - #{user.city} created"
end

puts "All NPCs Generated"

puts "Generating Groups..."

2.times do
  Group.create(
    name: Faker::App.name,
    description: Faker::Company.bs,
    city: "Shibuya-ku, Tokyo",
    gm: gandalf
    )
end

20.times do
  i = 0

  prefecture = PREFECTURES.sample

  city = if prefecture[:prefecture] == 'Tokyo'
          city_or_ward = prefecture.keys[rand(2..3)]
          city_or_ward == :ward ? "#{prefecture[city_or_ward].sample}-ku" : "#{prefecture[city_or_ward].sample}-shi"
          else
            "#{prefecture[:city].sample}-shi"
         end

  group = Group.create(
    name: Faker::App.name,
    description: Faker::Company.bs,
    city: "#{city}, Tokyo",
    gm: User.all.sample
    )
  puts "#{i += 1}. #{group.name} created"
end

puts "All Groups Created"

puts "Linking Users to Groups..."

groups = Group.where(city: 'Shibuya-ku, Tokyo')
groups.each do |group|
  PlayerGroup.create(user: gandalf, group: group) if group.gm != gandalf
end

30.times do
  status = true
  while status
    user = User.all.sample
    group = Group.all.sample
    if group.gm != user && !group.users.include?(user) && group.users.count < 5
      p_group = PlayerGroup.create(
      user: user,
      group: group
      )
      status = false
    end
  end
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
