# In the unlikely senario that someone is reading this;
# there's a driver_script.rb in this folder which showcases the assignment
# I also used my merge sort project but Array.sort would probably be better
# also also I didn't filter unique values.. because why? Array.uniq if I think of a reason
# also also also the rubocop hate is strong with this one. Mostly because of complexity and branch conditions
# Looking at other's solutions, I could've been more efficient by filtering the value more often
# cutting the part of the tree in half as it works.. the time complexity is high..
# oh! that's probably how I could fix all the linter issues

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

# Tree edit features, which you could probably decern from the module name.. rubocop
module Edit
  def insert(value, root = @root)
    if root.value > value
      root.left = Node.new(value) if root.left.nil?
      insert(value, root.left)
    elsif root.value < value
      root.right = Node.new(value) if root.right.nil?
      insert(value, root.right)
    end
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
end

# Depth first traversal methods
module DepthFirst
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
end

# Takes an array and turns it into a binary search tree
class BinarySearchTree
  include Edit
  include DepthFirst
  attr_accessor :root, :is_balanced

  def initialize(array)
    @array = merge_sort(array)
    @root = build_tree(@array)
    @is_balanced = true
  end

  def build_tree(array, head = 0, tail = array.size - 1)
    return nil if head > tail

    middle = (head + tail) / 2
    new_node = Node.new(array[middle])
    new_node.left = build_tree(array, head, middle - 1)
    new_node.right = build_tree(array, middle + 1, tail)

    new_node
  end

  # Returns two values: a node and a parent
  def find(value, root = @root, parent = nil)
    return "Value doesn\'t exsist in the tree" if root.nil?

    if root.value == value
      [root, parent]
    elsif root.value > value
      find(value, root.left, root)
    elsif root.value < value
      find(value, root.right, root)
    end
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

  def height(node = @root, count = 0)
    # Just saw this.. working on this project over multiple days..
    # I couldn't pass the integer because I wasn't returning the integer in every case!
    return count if node.nil?

    height(node.left, count + 1)
    height(node.right, count + 1)
  end

  def depth(original_node, node = @root, count = [])
    # well here is a different way to carry a count recursively
    # I don't understand why I can't increment an integer..
    original_node = find(original_node)[0] if original_node.is_a? Integer
    # Pass either a node or a value
    return if node.nil?

    if original_node.value <= node.value
      count << 'why does is carry an array'
      depth(original_node, node.left, count) unless node == original_node
    else
      count << 'but it wont carry and integer'
      depth(original_node, node.right, count) unless node == original_node
    end
    count.length - 1
  end

  def balanced?(node = @root)
    # This can't be the best way to do this.. I'm not sure why I couldn't pass the boolean recursively
    # Having a class variable was the only thing I could figure out..
    @is_balanced = true
    return if node.nil?

    unless node.left.nil? && node.right.nil?
      if node.left.nil?
        @is_balanced = false unless node.right.right.nil? && node.right.left.nil?
      elsif node.right.nil?
        @is_balanced = false unless node.left.left.nil? && node.left.right.nil?
      end
    end
    balanced?(node.left) if @is_balanced
    balanced?(node.right) if @is_balanced
    @is_balanced

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

# test = BinarySearchTree.new([10,20,30,40,50,60,70,80,90,100,4,3,2,5,6,7,8,7,5,4,3,2])

# test.pretty_print
# test.insert(9)
# test.pretty_print

# test.delete(20)
# test.delete(50)
# test.delete(3)
# test.pretty_print
# # p test.level_order
# # p test.inorder

# # test.inorder do |val|
# #   p val
# # end
# # p test.preorder
# # test.preorder do |val|
# #   p val
# # end
# # p test.postorder
# # test.postorder do |val|
# #   p val
# # end

# p test.height
# p test.balanced?

# test.reblance

# test.pretty_print
# p test.height
# p test.is_balanced
# p test.balanced?
# ro, par = test.find(10)
# p ro.value
# p par.value
# p test.depth(ro)
# p test.depth(100)