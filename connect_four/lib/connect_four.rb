require_relative 'winner'

class Board
  include Winner 
  attr_accessor :board

  def initialize
    @board = Array.new(6, nil)
    6.times { |i| @board[i] = Array.new(7, nil) }
  end

  def add_move(player, column)
    @board.each do |row|
      if row[column].nil?
        row[column] = player
        break
      end
    end
    @board 
  end

  def print_board
    @board.reverse_each do |row|
      p row
    end
  end

end

game = Board.new

game.add_move('x', 3)
game.add_move('x', 3)
game.add_move('x', 3)
game.add_move('x', 3)
game.print_board
