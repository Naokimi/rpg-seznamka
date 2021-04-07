require 'faker'
require 'database_cleaner/active_record'
require_relative 'data/genres_data.rb'
require_relative 'data/stations_scraper.rb'
require_relative 'data/rulebooks_data.rb'

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
  city: 'Shibuya-ku, Tokyo'
  )
puts "#{user_num += 1}. #{gandalf.nickname} Summoned: 'You Shall Not Pass!' 🧖🏼‍♂️"

puts "Generating NPCs..."

40.times do
  prefecture = PREFECTURES.sample

  city = if prefecture[:prefecture] == 'Tokyo'
          city_or_ward = prefecture.keys[rand(2..3)]
          city_or_ward == :ward ? "#{prefecture[city_or_ward].sample}-ku" : "#{prefecture[city_or_ward].sample}-shi"
          else
            "#{prefecture[:city].sample}-shi"
         end

  status = true

  while status
    nickname = Faker::Internet.username
    if !User.find_by(nickname: nickname)
      user = User.create!(
        email: Faker::Internet.email,
        nickname: nickname,
        password: '123456',
        city: "#{city}, #{prefecture[:prefecture]}"
        )
      puts "#{user_num += 1}. #{user.nickname} - #{user.city} created"
      status = false
    end
  end
end

puts "All NPCs Generated"

puts "Generating Groups..."
group_num = 0

2.times do
  group = Group.create!(
    name: Faker::App.name,
    description: Faker::Company.bs,
    city: "Shibuya-ku, Tokyo",
    gm: gandalf
    )
  puts "#{group_num += 1}. #{group.name} created"
end

20.times do

  prefecture = PREFECTURES.sample

  city = if prefecture[:prefecture] == 'Tokyo'
          city_or_ward = prefecture.keys[rand(2..3)]
          city_or_ward == :ward ? "#{prefecture[city_or_ward].sample}-ku" : "#{prefecture[city_or_ward].sample}-shi"
          else
            "#{prefecture[:city].sample}-shi"
         end

  status = true

  while status
    name = Faker::App.name
    if !Group.find_by(name: name)
      group = Group.create!(
        name: name,
        description: Faker::Company.bs,
        city: "#{city}, #{prefecture[:prefecture]}",
        gm: User.all.sample
        )
      status = false
      puts "#{group_num += 1}. #{group.name} created"
    end
  end
end

puts "All Groups Created"

puts "Linking Users to Groups..."

groups = Group.where(city: 'Shibuya-ku, Tokyo')
groups.each do |group|
  PlayerGroup.create!(user: gandalf, group: group) if group.gm != gandalf
end

30.times do
  status = true
  while status
    user = User.all.sample
    group = Group.all.sample
    if group.gm != user && !group.users.include?(user) && group.users.count < 5
      p_group = PlayerGroup.create!(
      user: user,
      group: group
      )
      status = false
    end
  end
end

puts "We have Player Groups 🕺"

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
    genre: genre,
    img_url: book[:img]
    )
  puts "#{index + 1}. #{rulebook.name} published"
end

puts "All Rulesbooks created"
