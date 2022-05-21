@roman_mapping = {
  1000 => "M",
  900 => "CM",
  500 => "D",
  400 => "CD",
  100 => "C",
  90 => "XC",
  50 => "L",
  40 => "XL",
  10 => "X",
  9 => "IX",
  5 => "V",
  4 => "IV",
  1 => "I"
}

def roman(n, answer = '')
  return answer if n == 0

  @roman_mapping.each do |key, val|
    if n >= key
      n -= key
      return roman(n, answer << val)
    end
  end
  answer
end


def collatz(n)
  return 0 if n == 1

  n.even? ? 1 + collatz(n / 2) : 1 + collatz(3 * n + 1)
end

def fact(n)
  n == 1 ? 1 : n * fact(n - 1)
end

def pallindrome(n, pos = 1)
  return false unless n[pos -1, 1] == n[-pos, 1]
  return true if pos > (n.length / 2)

  pallindrome(n, pos + 1)
end

def beer(n)
  n = 'no more' if n.zero?
  puts "#{n} bottles of beer on the wall"
  beer(n - 1) unless n == 'no more'
end

def fibonacci(n)
  return n if n <= 1
  fibonacci(n - 1) + fibonacci(n - 2)
end


puts "[1] Number \n[2] Word"
if gets.chomp.to_i == 1
  input = gets.chomp.to_i
  # puts "Factorial: #{fact(input)}"
  # puts "Collatz: #{collatz(input)}"
  # puts "Fibonacci: #{fibonacci(input)}"
  puts "Roman: #{roman(input)}"
  # beer(input)
else
  werd = gets.chomp
  puts "Pallindrome: #{pallindrome(werd)}"
end


#  1  2  3  4  5 6
# 20 21 22 23 24 7
# 19 32 33 34 25 8
# 18 31 36 35 26 9
# 17 30 29 28 27 10
# 16 15 14 13 12 11


