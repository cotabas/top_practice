def merge_sort(array, answer = [], left_answer = [], right_answer = [])
  p array.flatten
  if array.size <= 2
    return answer << (array[0] >= array[1] ? [array[1], array[0]] : [array[0], array[1]])
  end

  left = array.size.odd? ? (array.size + 1) / 2 : array.size / 2
  right = array.size - left
  left_answer << merge_sort(array.slice(0, left), answer, left_answer, right_answer)
  right_answer << merge_sort(array.slice(-right, right), answer, left_answer, right_answer)

  answer << (left_answer[0] < right_answer[0] ? left_answer[0] : right_answer[0])

  return answer.flatten
end

p merge_sort([2,1,3,4,6,5])

