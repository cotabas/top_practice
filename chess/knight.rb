# yeah

# Each node is a vertex on a graph of possible moves
class Node
  attr_accessor :vertex, :edges

  def initialize(vertex = nil, edges = [])
    @vertex = vertex
    @edges = edges
  end
end

# The knight piece graph
class Knight
  attr_accessor :start, :node_list

  def initialize(start = [0, 0])
    @moves = [[1, 2], [-1, 2], [2, 1], [-2, 1], [1, -2], [-1, -2], [2, -1], [-2, -1]]
    @node_list = []
    8.times do |x_cord|
      8.times do |y_cord|
        @node_list << Node.new([x_cord, y_cord])
      end
    end
    @node_list.each { |node| build_graph(node) }
    @start = node_list[0]
  end

  # Sets the edges to the nodes in their move set
  def build_graph(node)
    add_moves(node.vertex).each do |move|
      node.edges << @node_list.select { |nodle| nodle.vertex == move }
    end
  end

  def show_moves(vertex)
    
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

p test.node_list.size
p test.node_list.uniq.size
p test.add_moves([6,5])
p test.show_moves([6, 5])

