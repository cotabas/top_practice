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
    @visited = []
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

  # def knight_moves(start, target)
  #   answer = []
  #   final_answer = []
  #   answer_size = 99
  #   breadth_first(find(start), find(target)) do |node|
      
  #     node.each do |nod|
  #       answer << nod.vertex
  #     end
  #     if answer_size > answer.size && answer.size > 0
  #       final_answer = answer
  #       answer_size = answer.size
  #       answer = []
  #     end
  #     # p final_answer
  #     # @visited.each do |set|
  #     #   p "#{set[0]} at #{set[1].vertex}"
  #     # end
  #   end
  #   final_answer
  # end

  # A breadth first traversal of the graph.. doesn't provide any value..

  # def breadth_first(start, target, work = start, que = [work], nodes = [], &block)
  #   return nodes if que.size.zero?
  #   working = que.shift
  #   working.edges.each do |node|
  #     # p "#{nodes.size + 1} + #{node.vertex}"
  #     que << node unless @visited.include?([nodes.size + 1, node])
  #   end
  #   nodes << working
  #   if nodes[-1] == target
  #     nodes.each_with_index do |val, dex|
  #       @visited << [dex, val] unless val == start
  #     end
  #     que = [start]
  #     yield nodes
  #     nodes = []
  #   end
  #   breadth_first(start, target, working, que, nodes, &block)
  # end

  # Add valid moves
  def add_moves(start, return_array = [])
    @moves.each do |set|
      return_array << [start[0] + set[0], start[1] + set[1]]
    end
    return_array.select { |set| set[0].between?(0, 7) && set[1].between?(0, 7) }
  end

  def knight_moves(start, target)
    answer = []
    final_answer = []
    starting_size = 999
    breadth_first(find(start), find(target)) do |path|
      path.each { |node| answer << node.vertex }
      if starting_size > answer.size
        final_answer = answer 
        starting_size = answer.size
      end
      answer = []
    end
    final_answer
  end

  def breadth_first(start, target, nodes = [], &block)
    nodes << start
    return nodes if start == target
    # if start == target
    #   yield nodes
    # end
    start.edges.each do |node|
      return nodes if node == target
      breadth_first(node, target, nodes, &block) unless node == target
    end
    nodes
  end
end

test = Knight.new

p test.add_moves([6,5])
p test.node_list.size
# p test.knight_moves([0, 0], [3, 3])
# p test.knight_moves([3, 3], [4, 3])
test.breadth_first(test.find([0, 0]), test.find([3, 3])).each do |node|
  p node.vertex
end
