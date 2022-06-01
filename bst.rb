require_relative 'merge_sort'
# The object for the leaves and branches of this tree
class Node
  attr_accessor :value, :left, :right

  def initialize(val = nil, left = nil, right = nil)
    @value = val
    @left = left
    @right = right
  end
end

class BinarySearchTree
  attr_accessor :root

  def initialize(array)
    @array = merge_sort(array)
    @root = build_tree(@array)
  end

  def build_tree(array, head = 0, tail = array.size)
    return nil if head > tail

    middle = (head + tail) / 2
    new_node = Node.new(array[middle])
    new_node.left = build_tree(array, head, middle - 1)
    new_node.right = build_tree(array, middle + 1, tail)

    new_node
  end

  def insert(value, root = @root)
    root.left = Node.new(value) if root.left.nil? && root.value > value
    root.right = Node.new(value) if root.right.nil? && root.value < value

    insert(value, root.left) if root.value > value
    insert(value, root.right) if root.value < value
    root
  end

  def delete(value)
    local, parent = find(value)
    if local.left.nil? && local.right.nil?
      parent.left = nil if parent.left == local
      parent.right = nil if parent.right == local
    elsif local.left.nil?
      parent.right = local.right if parent.right == local
      parent.left = local.right if parent.left == local
    elsif local.right.nil?
      parent.right = local.left if parent.right == local
      parent.left = local.left if parent.left == local
    else
      
      # make traversal methods first
    end

  end

  def find(value, root = @root, parent = nil)
    if root.value == value
      [root, parent]
    elsif root.value > value
      find(value, root.left, root)
    elsif root.value < value
      find(value, root.right, root)
    end rescue "Value doesn\'t exsist in the tree" 
    # rails #try seems cool, I would use it here..
  end

  def level_order(node = @root, que = [node], ordered = [])
    
    working = que.shift
    ordered << working.value
    que << working.left unless working.left.nil?
    que << working.right unless working.right.nil?
    level_order(working, que, ordered) unless que.size == 1
    ordered

  end


  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

test = BinarySearchTree.new([10,20,30,40,50,60,70,80,90,100])

test.pretty_print
test.insert(9)
test.pretty_print
ro, par = test.find(10)
p ro.value
p par.value
test.delete(90)
test.pretty_print
p test.level_order