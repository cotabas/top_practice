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
    @moves = [[1, 2], [-1, 2], [2, 1], [-2, 1], [1, -2], [-1, -2], [2, -1], [-2, -1]]
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

  # def knight_moves(start, target)
  #   answer = []
  #   final_answer = []
  #   starting_size = 999
  #   breadth_first(find(start), find(target)) do |path|
  #     path.each { |node| answer << node.vertex }
  #     if starting_size > answer.size
  #       final_answer = answer 
  #       starting_size = answer.size
  #     end
  #     answer = []
  #   end
  #   final_answer
  # end

  # def breadth_first(start, target, nodes = [], &block)
  #   nodes << start
  #   return nodes if start == target
  #   # if start == target
  #   #   yield nodes
  #   # end
  #   start.edges.each do |node|
  #     return nodes if node == target
  #     breadth_first(node, target, nodes, &block) unless node == target
  #   end
  #   nodes
  # end

  # def dijkstra(start, target)
  #   distances = []
  #   que = []
  #   working_list = []
  #   @node_list.each { |node| working_list << node }
  #   working_node = find(start)
  #   depth = 1
  #   progress_check = 0
  #   target_dex = index(target)
  #   answer = []
  #   final_answer = [1,1,1,1,1,1,1,1,1,1,1,1,1,11,1,1,1,1]
  #   64.times do |dex|
  #     distances << Float::INFINITY
  #   end
  #   distances[0] = 0
    
  #   until progress_check == distances.sum && progress_check != Float::INFINITY
  #     progress_check = distances.sum
  #     working_node.edges.each do |edges|
  #       working_list.each_with_index do |node, dex|
  #         if edges == node
  #           answer << @node_list[dex].vertex
  #           if dex == target_dex
  #             final_answer = answer unless final_answer.size < answer.size
  #             answer = []
  #           end
  #           distances[dex] = depth unless distances[dex] < depth
  #           que << node
  #         end
  #       end
  #     end
  #     depth += 1
  #     working_node = que.shift
  #   end
  #   # distances.each_with_index do |dist, dex|
  #   #   p "at: #{@node_list[dex].vertex} dist: #{dist}"
  #   # end
  #   p final_answer
  # end

  def dijkstra(start, target)
    distances = []
    path = []
    que = []
    working_list = []
    begining = index(start)
    64.times do |dex|
      working_list << nil
      distances << []
      path << [1,1,1,1,1,1,1,1,1,1,1,1,1]
      # que << dex
    end

    @node_list.each_with_index do |node, dex| 
      if dex < begining
        working_list[dex + (working_list.size - begining)] = node
      else
        working_list[[(dex - begining), 0].max] = node
      end
    end

    distances[0] = []
    answer = []
    final_answer = [1,1,1,1,1,1,1,1,1,1,1]
    que = [0]

    164.times do
      queue = que.shift

      # p working_list[queue].vertex
      working_list[queue].edges.each do |edge|
        working_list.each_with_index do |node, dex|
          if edge == node
            que << dex
            if distances[queue] = []
              distances[dex] << working_list[queue].vertex 
            else
              distances[dex] = distances[queue]
            end
            if node.vertex == target
              final_answer << distances[dex] << node.vertex
              distances[dex] = []
            end
          end
        end
      end
    end

    # distances.each_with_index do |dist, dex|
    #   p "at: #{@working_list[dex].vertex} dist: #{dist}"
    # end
        

    # p distances
    distances.each_with_index do |ver, dex|
      p "#{dex} #{working_list[dex].vertex} Path: #{ver}"
    end

    p  final_answer

  end

  def index(node)
    @node_list.each_with_index do |nod, dex|
      return dex if find(node) == nod
    end
  end

end

test = Knight.new

p test.add_moves([3,3])
p test.node_list.size
# p test.knight_moves([0, 0], [3, 3])
# p test.knight_moves([3, 3], [4, 3])
test.dijkstra([3, 3], [4, 3])
# test.dijkstra([0, 0], [3, 3])


# ok, the moves for [0, 0] and all one distance away
# then those moves are one distance from their moves
#  so those moves would be 2 away from [0, 0]
