def caesar_cipher(phrase, shift_factor)
  result = ""
  phrase.each_char {|char|
    if char.ord.between?(97, 122)
      if (char.ord - shift_factor) <= 97
        result += (123 - (97 - (char.ord - shift_factor))).chr
      else 
        result += (char.ord - shift_factor).chr
      end
    elsif char.ord.between?(65, 90)
      if (char.ord - shift_factor) <= 65
        result += (91 - (65 - (char.ord - shift_factor))).chr
      else 
        result += (char.ord - shift_factor).chr
      end
    else
      result += char
    end
  }
p result
end
puts "Type phrase:"
phrase = gets.chomp
puts "Shift factor?"
shift_factor = gets.chomp

caesar_cipher(phrase, shift_factor.to_i)

# a = 97
# z = 122
# A = 65
# Z = 90