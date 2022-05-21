def caesar_cipher(phrase, shift_factor)
    result = ""
    shift_factor = shift_factor * -1
    phrase.each_char {|char|
      if char.ord.between?(97, 122)
        if (char.ord - shift_factor) >= 122
          result += (97 + ((char.ord - shift_factor) - 121)).chr
        else 
          result += (char.ord - shift_factor).chr
        end
      elsif char.ord.between?(65, 90)
        if (char.ord - shift_factor) >= 90
          result += (65 + ((char.ord - shift_factor) - 90)).chr
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