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

  def delete(value, root = @root)
    local = find(value)
    
  end

  def find(value, root = @root)
    if root.value == value
      root
    elsif root.value > value
      find(value, root.left)
    elsif root.value < value
      find(value, root.right)
    end rescue "Value doesn\'t exsist in the tree" 
    # rails #try seems cool, I would use it here..
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
p test.find(109)
