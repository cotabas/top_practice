def bubble_sort(numbers)
  until checkr(numbers)
    numbers.each_index do |index|
      one = numbers[index]
      two = numbers[index + 1]
      if two != nil 
        if one > two
          numbers[index + 1] = one
          numbers[index] = two
        end
      end
    end
  end
  numbers
end

def checkr(numbers)
  numbers.each_index do |index|
    one = numbers[index]
    two = numbers[index + 1]
    if two != nil 
      if one > two
        return false
      end
    end
  end
  true
end

p bubble_sort([4,3,78,2,0,2,4,3,78,2,0,2,4,3,78,2,0,2,4,3,78,2,0,2,4,3,78,2,0,2])