class Board
  
  attr_accessor :board

  def initialize
    @board = Array.new(6, Array.new(7, nil))
  end

  def check_winner(board_state)
    check_horizontal(board_state)
  end

  def check_horizontal(board_state)
    board_state.each do |row| 
      return 'x' if row.include?(['x','x','x','x'])
    end
    false
  end

end
