require_relative 'winner'

class Board
  include Winner 
  attr_accessor :board

  def initialize
    @board = Array.new(6, Array.new(7, nil))
  end

end


