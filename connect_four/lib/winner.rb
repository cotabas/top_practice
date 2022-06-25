module Winner

  def winner?(board_state, player)
    return player if check_horizontal(board_state, player) || check_vertical(board_state, player) || check_diagonal(board_state, player)
  end

  def check_horizontal(board_state, player)
    board_state.each do |row|
      count = 0
      row.each do |slot|
        count = slot ==  player ? count + 1 : 0
        return true if count == 4
      end
    end
    false
  end

  def check_vertical(board_state, player)
    7.times do |col|
      count = 0
      board_state.each do |row|
        count = row[col] == player ? count + 1 : 0
        return true if count == 4
      end
    end
    false
  end

  def check_diagonal(board_state, player)
    #  This looks confusing.. it checks for four diaganols in a row starting from the bottom left corner
    #  Then it check for diaganols starting from the top left corner
    #  Basically it checks forward slash and back slash across the board
    3.times do |row|
      4.times do |col|
        count = 0
        4.times do |i|
          count = board_state[row + i][col + i] == player ? count + 1 : 0
        end
        return true if count == 4
        count = 0
        4.times do |i|
         count = board_state[row + (3 - i)][col + i] == player ? count + 1 : 0
        end
       return true if count == 4
      end
    end
  end
end
