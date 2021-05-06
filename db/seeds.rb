require 'faker'
require 'database_cleaner/active_record'
require_relative 'data/genres_data.rb'
require_relative 'data/stations_scraper.rb'
require_relative 'data/rulebooks_data.rb'

# Scraper can be found in the 'db' folder
data = scraper

def available_times
  availability = {sunday: [], monday:[], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: []}
  weekday_times = [12..15, 16..19, 20..23]
  weekend_times = [7..11, 13..16, 17..20, 23..1]
  non_work_nights = [:friday, :saturday]
  days = availability.keys
  days.each do |day|
    if non_work_nights.include?(day)
      rand(1..4).times do
        run = true
        while run
          weekend_time_slot = weekend_times.sample
          if !availability[day].include?(weekend_time_slot)
            availability[day].push(weekend_time_slot)
            run = false
          end
        end
      end
    else
      rand(1..3).times do
        run = true
        while run
          weekday_time_slot = weekday_times.sample
          if !availability[day].include?(weekday_time_slot)
            availability[day].push(weekday_time_slot)
            run = false
          end
        end
      end
    end
  end
  availability
end

puts "Clearing out the battlefield 🌋..."
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean
puts "Battlefield Cleared ⛰"

user_num = 0
puts "Summoning Gandalf 🧙🏻‍♂️"

gandalf = User.create!(
  email: 'gandalf@gmail.com',
  nickname: 'GandalfTheWhite',
  password: '123456',
  train_station: 'Shibuya Station',
  availability: available_times
  )
puts "#{user_num += 1}. #{gandalf.nickname} Summoned: 'You Shall Not Pass!' 🧖🏼‍♂️"

puts "Generating NPCs..."

10.times do
  status = true
  while status
    nickname = Faker::Internet.username
    area = data.sample
    if !User.find_by(nickname: nickname)
      user = User.create!(
        email: Faker::Internet.email,
        nickname: nickname,
        password: '123456',
        train_station: "#{area[:stations].sample}, #{area[:prefecture]}",
        availability: available_times
        )
      puts "#{user_num += 1}. #{user.nickname} - #{user.train_station} created"
      status = false
    end
  end
end

puts "All NPCs Generated"

puts "Generating Genres..."

RPG_GENRES.each_with_index do |genre, index|

  rpg = Genre.create!(
    name: genre[:name],
    description: genre[:description]
    )
  puts "#{index + 1}. #{rpg.name} created"

end

puts "Genres Created 🔠"

puts "Deciding what Users prefer..."

gandalfs_preference = Genre.all.sample
Preference.create!(
  user: gandalf,
  genre: gandalfs_preference
  )

User.all.each do |user|
  status = true
  while status
    genre = Genre.all.sample
    if !user.preferences.include?(genre)
      Preference.create!(
        user: user,
        genre: genre
        )
      status = false
    end
  end
end

puts "They decided"

puts "Creating the Rulebooks..."

BOOK_TITLES.each_with_index do |book, index|
  genre = Genre.find_by(name: book[:genre])
  rulebook = Rulebook.create!(
    name: book[:title],
    description: book[:description],
    img_url: book[:img]
    )
  Pairing.create!(
    genre: genre,
    rulebook: rulebook
    )
  puts "#{index + 1}. #{rulebook.name} published"
end

puts "All Rulebooks created"

puts "Generating Groups..."
group_num = 0

# add a conditional so that user does not have the same times
session_day = gandalf.availability.keys.shuffle.first(2)
index = 0
2.times do
  session_time = gandalf.availability[session_day[index]].sample
  rulebook = Rulebook.all.sample
  group = Group.create!(
    name: Faker::App.name,
    description: Faker::Company.bs,
    train_station: "Shibuya Station, Tokyo",
    rulebook: rulebook,
    gm: gandalf,
    session_times: {session_day[index] => [session_time]}
    )
  puts "#{group_num += 1}. #{group.name} created"
  index += 1
end

30.times do
  area = data.sample
  rulebook = Rulebook.all.sample
  user = User.all.sample
  available_day = user.availability.keys.sample
  session_time = user.availability[available_day]
  status = true
  while status
    name = Faker::App.name
    if !Group.find_by(name: name)
      group = Group.create!(
        name: name,
        description: Faker::Company.bs,
        rulebook: rulebook,
        train_station: user.train_station,
        gm: user,
        session_times: {available_day => session_time}
        )
      status = false
      puts "#{group_num += 1}. #{group.name} - #{group.train_station} created"
    end
  end
end

puts "All Groups Created"

puts "Linking Users to Groups..."
groups = Group.where(train_station: 'Shibuya Station, Tokyo')
groups.each do |group|
  PlayerGroup.create!(user: gandalf, group: group) if group.gm != gandalf
end

def genre_pref_match?(preferences_array, genres_array)
  result = false
  preferences_array.each do |preference|
    result = true if genres_array.include?(preference)
  end
  result
end

40.times do
  status = true
  while status
    user = User.all.sample
    preferences = user.preferences.map { |preference| preference.genre.name }
    group = Group.all.sample
    genres = group.rulebook.genres.map { |genre| genre.name }
    if group.gm != user && !group.users.include?(user) && group.users.count < 5 && genre_pref_match?(preferences, genres)
      p_group = PlayerGroup.create!(
      user: user,
      group: group
      )
      status = false
    end
  end
end

puts "We have Player Groups 🕺"
