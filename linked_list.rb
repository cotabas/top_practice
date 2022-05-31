class LinkedList
  attr_accessor :head_node, :tail_node

  def prepend(val)
    hmm = Node.new(val, @head_node)
    @tail_node = hmm if @tail_node.nil?
    @head_node = hmm
  end

  def append(val)
    hmm = Node.new(val)
    @head_node = hmm if @head_node.nil?
    @tail_node.next_node = hmm unless @tail_node.nil?
    @tail_node = hmm
  end

  def size(pointer = @head_node, count = -1)
    count += 1
    pointer.next_node.nil? ? count : size(pointer.next_node, count)
  end

  def head
    @head_node.value
  end

  def tail
    @tail_node.value
  end

  def at(dex, pointer = @head_node, count = -1)
    count += 1
    count == dex ? pointer : at(dex, pointer.next_node, count) rescue nil 
    # maybe figure out how to return nil in a better way..
  end

  def pop
    @tail_node = at(size - 1)
    at(size - 1).next_node = nil
  end

  def contains?(val, pointer = @head_node, count = -1)
    count += 1
    return false if count == size + 1

    pointer.value == val ? true : contains?(val, pointer.next_node, count)
  end

  def find(val, pointer = @head_node, count = -1)
    count += 1
    return nil if count == size + 1

    pointer.value == val ? count : find(val, pointer.next_node, count)
  end

  def insert_at(val, dex)
    case 
    when dex == 0
      prepend(val)
    when dex >= size
      append(val)
    else
      at(dex - 1).next_node = Node.new(val, at(dex))
    end
  end

  def remove_at(dex)
    at(dex - 1).next_node = at(dex + 1)
  end

  def to_s
    count = 0
    holding = ''
    until count == size
      holding << "#{at(count).value} -> "
      count += 1
    end
    puts holding << 'nil'
  end

  def each
    count = 0
    until count == size
      yield at(count).value
      count += 1
    end
  end

  def each_with_index
    index = 0
    each do |val|
      yield(val, index)
      index += 1
    end
  end
end

class Node
  attr_accessor :value, :next_node

  def initialize(val = nil, next_node = nil)
    @value = val
    @next_node = next_node
  end

end


# Test procedures:

linked_list = LinkedList.new
linked_list.prepend("prudence")
linked_list.append("cat")
linked_list.append("bruce")
linked_list.prepend("MORE CATS")
linked_list.prepend("prudence")
linked_list.append("cat")
linked_list.append("bruce")
linked_list.prepend("MORE CATS")
linked_list.prepend("prudence")
linked_list.append("cat")
linked_list.append("bruce")
linked_list.prepend("MORE CATS")
linked_list.prepend("prudence")
linked_list.append("cat")
linked_list.append("bruce")
linked_list.prepend("MORE CATS")
linked_list.prepend("prudence")
linked_list.append("cat")
linked_list.append("bruce")
linked_list.prepend("MORE CATS")
linked_list.append(3)
linked_list.append(3)
p linked_list.head_node
p linked_list.tail
p linked_list.head
p linked_list.at(5)
p linked_list.size
p linked_list.pop
p linked_list.head_node
p linked_list.contains?("cat")
p linked_list.find("cat")
p linked_list.head_node
 linked_list.insert_at("WAHWAHCATS!", 9)
 linked_list.append("bruce")
 linked_list.append("bruce")
  linked_list.remove_at(2)
p linked_list.head_node
p linked_list.tail

linked_list.to_s

# cool...
linked_list.each do |val|
  p val
end
linked_list.each_with_index do |val, dex|
  puts "#{dex}: #{val}"
end
