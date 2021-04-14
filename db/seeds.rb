require 'faker'
require 'database_cleaner/active_record'
require_relative 'data/genres_data.rb'
require_relative 'data/stations_scraper.rb'
require_relative 'data/rulebooks_data.rb'

# Scraper can be found in the 'db' folder
data = scraper

def available_times
  availability = {sunday: [], monday:[], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: []}
  days = availability.keys
  days.each do |day|
    rand(5..8).times do
      run = true
      while run
        hour = rand(0..23)
        if !availability[day].include?(hour)
          availability[day].push(hour)
          run = false
        end
      end
    end
    availability[day].sort!
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

40.times do
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

2.times do
  rulebook = Rulebook.all.sample
  group = Group.create!(
    name: Faker::App.name,
    description: Faker::Company.bs,
    train_station: "Shibuya Station, Tokyo",
    rulebook: rulebook,
    gm: gandalf,
    session_times: gandalf.availability
    )
  puts "#{group_num += 1}. #{group.name} created"
end

20.times do
  area = data.sample
  rulebook = Rulebook.all.sample
  user = User.all.sample
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
        session_times: user.availability
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

30.times do
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
