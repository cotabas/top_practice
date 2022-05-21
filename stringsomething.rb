dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit", "go"]

def substrings(str, dict)
  str = str.downcase
  words = str.split(" ")
  hashola = Hash.new
  words.each do |str_word|    
    dict.each do |dict_word|
      counter = hashola[dict_word] ? hashola[dict_word] + 1 : 1
      word_hash = { dict_word => counter }
      hashola = str_word.match?(dict_word) ? hashola.merge(word_hash) : hashola
    end
  end
  hashola
end


p substrings("Howdy partner, sit down! How's it going?", dictionary)

