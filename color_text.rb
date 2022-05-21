system "echo '\e[1;41m  \e[0m'"
system "echo '\e[1;32m This is green text \e[0m'"
system "echo '\e[1;33m This is yellow text \e[0m'"
system "echo '\e[1;34m This is blue text \e[0m'"
system "echo '\e[1;35m This is purple text \e[0m'"
system "echo '\e[1;36m This is teal text \e[0m'"
puts "hello"

test = 32

system "echo '\e[1;#{test}m hmm \e[0m'"
RED = '\e[1;31m'
GREEN = '\e[1;32m'
YELLOW = '\e[1;33m'
BLUE = '\e[1;34m'
PURPLE = '\e[1;35m'
TEAL = '\e[1;36m'
RED_BACK = '\e[1;41m'
GREEN_BACK = '\e[1;42m'
YELLOW_BACK = '\e[1;43m'
BLUE_BACK = '\e[1;44m'
PURPLE_BACK = '\e[1;45m'
TEAL_BACK = '\e[1;46m'

puts "▊╳"

# system "echo '#{RED_BACK}  \e[0m  #{GREEN_BACK}  \e[0m  #{YELLOW_BACK}  \e[0m  #{BLUE_BACK}  \e[0m  #{PURPLE_BACK}  \e[0m  #{TEAL_BACK}  \e[0m  '"
COLOR_BACK_ARRAY = [
  RED_BACK,
  GREEN_BACK,
  YELLOW_BACK,
  BLUE_BACK,
  PURPLE_BACK,
  TEAL_BACK
]


result = ''
COLOR_BACK_ARRAY.each do |val|
  result += "#{val}  \e[0m  "
end
system "echo '#{result}'"
