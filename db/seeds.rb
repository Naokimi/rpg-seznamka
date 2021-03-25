require 'faker'

puts "Clearing out the battlefield 🌋..."
User.destroy_all
PlayerGroup.destroy_all
Group.destroy_all
Preference.destroy_all
Rulebook.destroy_all
Genre.destroy_all
puts "Battlefield Cleared ⛰"

puts "Summoning Gandalf 🧙🏻‍♂️"
gandalf = User.new
gandalf.email = 'gandalf@gmail.com'
gandalf.nickname = 'GandalfTheWhite'
gandalf.password = '123456'
gandalf.city = 'Tokyo'
gandalf.save
puts "Gandalf Summoned: 'You Shall Not Pass! 🧖🏼‍♂️'"

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
50.times do
  group = Group.new
  group.name = Faker::App.name
  group.description = Faker::Company.bs
  group.city = Faker::Address.city
  group.gm = User.all.shuffle.first
  group.save
  puts "#{group.name} created"
end
puts "All Groups Created"

puts "Linking Users to Groups..."
30.times do
  p_group = PlayerGroup.new
  p_group.user = User.all.shuffle.first
  p_group.group = Group.all.shuffle.first
  p_group.save
end
puts "We have Player Groups 🕺"
