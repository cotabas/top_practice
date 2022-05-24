def merge_sort(array)
  # Why is the assignment branch condition size for merge_sort too high?

  return [array[0]] if array.size == 1

  left_side = array.slice(0, (array.size.odd? ? (array.size + 1) / 2 : array.size / 2))
  right_side = array.slice(-(array.size - left_side.size), (array.size - left_side.size))

  merge(merge_sort(left_side), merge_sort(right_side))
end

def merge(left, right, answer = [])
  (left.size + right.size).times do
    break answer << left if right.empty?
    break answer << right if left.empty?

    answer << (left[0] > right[0] ? right.slice!(0, 1) : left.slice!(0, 1))
  end

  answer.flatten
end

p merge_sort([2,9,1,7,6,29,456,457,5,4,2,4,6,5,7,23,24,25,26,21,20])

