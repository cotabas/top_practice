require 'pry-byebug'

puts "What's your name?"
name = gets.chomp
puts "How old are you?"
age = gets.chomp

time = 0
puts "Hello, #{name},"
4.times do
  time += 10
  puts "In #{time} years you will be:\n #{age.to_i + time} years old"
end

def yell_greeting(string)
  name = string

  binding.pry

  name = name.upcase
  greeting = "WASSAP, #{name}!"
  puts greeting
end

yell_greeting("bob")