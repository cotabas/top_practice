# yeah


# Each node is a vertex on a graph of possible moves
class Node
  attr_accessor :vertex, :edges

  def initialize(vertex)
    @vertex = vertex
    @edges = []
  end
end

# The knight piece graph
class Knight
  attr_accessor :start, :node_list

  def initialize
    @moves = [1, 2, -1, -2].permutation(2).to_a
    @node_list = []
    8.times do |x_cord|
      8.times do |y_cord|
        @node_list << Node.new([x_cord, y_cord])
      end
    end
    edges
    @start = find([0, 0])
  end

  # Add the edges and make the graph un-seeable..
  def edges
    @node_list.each do |node|
      add_moves(node.vertex).each do |set|
        @node_list.each { |compare_node| node.edges << compare_node if set == compare_node.vertex }
      end
    end
  end

  # Find a node when given coordinates
  def find(vertex)
    @node_list.each { |node| return node if node.vertex == vertex }
  end

  def knight_moves(start, target)

  end

  # A breadth first traversal of the graph.. doesn't provide any value..
  def breadth_first(start = @start, que = [start], nodes = [])
    working = que.shift
    working.edges.each do |node|
      que << node unless nodes.include?(node) || que.include?(node)
    end
    nodes << working
    breadth_first(working, que, nodes) unless que.size.zero?
    nodes
  end

  # Add valid moves
  def add_moves(start, return_array = [])
    @moves.each do |set|
      return_array << [start[0] + set[0], start[1] + set[1]]
    end
    return_array.select { |set| set[0].between?(0, 7) && set[1].between?(0, 7) }
  end
end

test = Knight.new

p test.add_moves([6,5])
p test.breadth_first.size
p test.node_list.size