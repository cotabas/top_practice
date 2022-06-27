require_relative 'winner'

class Board
  include Winner 
  attr_accessor :board

  def initialize
    @board = Array.new(6, nil)
    6.times { |i| @board[i] = Array.new(7, ' ') }
    @board << (1..7).to_a
  end

  def add_move(player, column)
    @board.each do |row|
      if row[column] == ' '
        row[column] = player
        break
      end
    end
    @board 
  end

  def turn(player)
    puts "It's #{player}'s turn, which column do you want?"
    answer = gets.chomp
    add_move(player, answer.to_i - 1)
    winner?(@board, player)
  end

  def print_board
    @board.reverse_each do |row|
      print = ''
      row.each do |space|
        print += "| #{space} |"
      end
      puts print
    end
  end

end

game = Board.new

loop do
  system('clear')
  game.print_board
  if game.turn('x') == 'x'
    puts "Congrats, X you won!"
    break
  end
  system('clear')
  game.print_board
  if game.turn('o') == 'o'
    puts "Congrats, O you won!"
    break
  end
end
