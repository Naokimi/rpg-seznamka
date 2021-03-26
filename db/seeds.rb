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
  city: 'Tokyo'
  )
puts "#{gandalf.nickname} Summoned: 'You Shall Not Pass! 🧖🏼‍♂️'"

puts "Generating NPCs..."
40.times do
  user = User.new
  user.email = Faker::Internet.email
  user.nickname = Faker::Internet.username
  user.password = '123456'
  user.city = Faker::Address.city
  user.save
  puts "#{user.nickname} from #{user.city} created"
end
puts "All NPCs Generated"

puts "Generating Groups..."
20.times do
  group = Group.new
  group.name = Faker::App.name
  group.description = Faker::Company.bs
  group.city = Faker::Address.city
  group.gm = User.randuser
  group.save
  puts "#{group.name} created"
end
puts "All Groups Created"

puts "Linking Users to Groups..."
30.times do
  user = randUser
  group = randGroup
  group = randGroup if group.gm == user
  p_group = PlayerGroup.new
  p_group.user = user
  p_group.group = group
  p_group.save
end
puts "We have Player Groups 🕺"


# See why this doesnt work...
private

def randUser
  User.all.sample
end

def randGroup
  Group.all.sample
end

