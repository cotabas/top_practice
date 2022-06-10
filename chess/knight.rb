# This was tough, and maybe not the best way to do it, certainly someparts could be improved
# However I learned a lot and became comfortable with some concepts that I already understood

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
    @long_array = Array.new(1000)
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

  # Add valid moves
  def add_moves(start, return_array = [])
    @moves.each do |set|
      return_array << [start[0] + set[0], start[1] + set[1]]
    end
    return_array.select { |set| set[0].between?(0, 7) && set[1].between?(0, 7) }
  end

  # Creates a list of the verticies with the start at zero index
  def create_working_list(start, working_list = Array.new(64))
    begining = index(start)
    @node_list.each_with_index do |node, dex|
      if dex < begining
        working_list[dex + (working_list.size - begining)] = node
      else
        working_list[[(dex - begining), 0].max] = node
      end
    end
    working_list
  end

  def dijkstra_ish(start, target, que = [0], shortest_path = @long_array)
    distances = Array.new(64, @long_array)
    working_list = create_working_list(start)

    # There's is definitely a better way to do this
    1000.times do
      queue = que.shift
      working_list[queue].edges.each do |edge|
        working_list.each_with_index do |node, dex|
          next unless edge == node

            que << dex
            distances[dex] = distances[queue] == @long_array ? working_list[queue].vertex : distances[queue] + working_list[queue].vertex
            if node.vertex == target && [distances[dex][0], distances[dex][1]] == start
              shortest_path = distances[dex] + target if shortest_path.size > (distances[dex].size + 2)
              distances[dex] = []
            end
        end
      end
    end
    shortest_path
  end

  def knight_moves(start, target)
    path = dijkstra_ish(start, target)
    puts "Moving from #{start} to #{target} takes #{(path.size / 2) - 1} moves"
    puts "[#{path.shift}, #{path.shift}]" until path.size.zero?
  end

  def print_paths(distances, working_list)
    distances.each_with_index do |ver, dex|
      p "#{dex} #{working_list[dex].vertex} Path: #{ver}"
    end
  end

  def index(node)
    @node_list.each_with_index do |nod, dex|
      return dex if find(node) == nod
    end
  end
end

test = Knight.new

# # TEST BLOCK # #

# p test.add_moves([5, 0])
# p test.node_list.size
test.knight_moves([0, 0], [3, 3])
test.knight_moves([3, 3], [4, 3])
# test.dijkstra_ish([3, 3], [4, 3])
# test.dijkstra_ish([0, 0], [3, 3])
# test.dijkstra_ish([3, 3], [0, 0])
# test.dijkstra_ish([5, 0], [7, 7])

