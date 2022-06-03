require_relative 'bst'

tree = BinarySearchTree.new(Array.new(15) { rand(1..100) })

tree.pretty_print

p "Balanced? #{tree.balanced?}"

p "Level Order: #{tree.level_order}"
p "Pre-order: #{tree.preorder}"
p "In-order: #{tree.inorder}"
p "Post-order: #{tree.postorder}"

15.times { tree.insert(rand(100..200)) }

tree.pretty_print

p "Balanced? #{tree.balanced?}"
tree.reblance

tree.pretty_print
p "Balanced? #{tree.balanced?}"

p "Level Order: #{tree.level_order}"
p "Pre-order: #{tree.preorder}"
p "In-order: #{tree.inorder}"
p "Post-order: #{tree.postorder}"
