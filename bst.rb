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

  def build_tree(array, head = 0, tail = array.size - 1)
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
    # Find returns the node with the value and its parent
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
      min_array = level_order(local)
      min_array.each do |val|
        min_array = min_array-[val] if val <= local.value
      end
      succ_local = find(min_array.min)
      delete(succ_local[0].value)
      local.value = succ_local[0].value
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

  # Breadth first
  def level_order(node = @root, que = [node], ordered = [])
    working = que.shift
    ordered << working.value
    que << working.left unless working.left.nil?
    que << working.right unless working.right.nil?
    level_order(working, que, ordered) unless que.size == 0
    ordered
  end

  # Depth first
  def inorder(node = @root, array = [], &block)
    return array if node.nil?

    inorder(node.left, array, &block)
    array << node.value
    yield node.value if block_given?
    inorder(node.right, array, &block)
  end

  def preorder(node = @root, array = [], &block)
    return array if node.nil?

    array << node.value
    yield node.value if block_given?
    preorder(node.left, array, &block)
    preorder(node.right, array, &block)
  end

  def postorder(node = @root, array = [], &block)
    return array if node.nil?

    postorder(node.left, array, &block)
    postorder(node.right, array, &block)
    yield node.value if block_given?
    array << node.value
  end

  def height(node = @root, count = 0)
    return count if node.nil?

    height(node.left, count + 1)
    height(node.right, count + 1)
  end

  def depth(node, count = 0)

  end

  def balanced?(node = @root, is_balanced = true)
    return true if node.nil?

    # return false if height(node.left) + 1 > height(node.right)

    balanced?(node.left)
    balanced?(node.right)
  end

  def reblance
    initialize(level_order)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

test = BinarySearchTree.new([10,20,30,40,50,60,70,80,90,100,4,3,2,5,6,7,8,7,5,4,3,2])

test.pretty_print
test.insert(9)
test.pretty_print
ro, par = test.find(10)
p ro.value
p par.value
test.delete(20)
test.delete(50)
test.delete(3)
test.pretty_print
# p test.level_order
# p test.inorder

# test.inorder do |val|
#   p val
# end
# p test.preorder
# test.preorder do |val|
#   p val
# end
# p test.postorder
# test.postorder do |val|
#   p val
# end

p test.height

test.reblance

test.pretty_print

p test.balanced?