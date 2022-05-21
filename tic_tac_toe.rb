turn_num = 0
board = [
  [' ', ' | ', ' ', ' | ', ' '],
  [' ', ' | ', ' ', ' | ', ' '],
  [' ', ' | ', ' ', ' | ', ' ']
]

def show_choices(board, choice = 1)
  board.each_index do |index|
    board[index].each_index do |cell|
      unless [' | ', 'X', 'O'].include?(board[index][cell])
        board[index][cell] = String(choice)
        choice += 1
      end
    end
  end

  [board, choice - 1]
end

def clear
  system 'clear'
  system 'cls'
end

def print_board(board)
  board.each_index do |index|
    result = ''

    board[index].each do |cell|
      result += cell
    end

    puts '--+---+--' if [1, 2].include?(index)
    puts result
  end
end

def get_choice(max)
  puts "\n Choose a number (1 - #{max}):"
  gets.chomp
end

def find_cell(board, choice)
  x, y = ''
  board.each_index do |index|
    board[index].map.with_index do |val, cell|
      x = val == String(choice) ? index : x
      y = val == String(choice) ? cell : y
    end
  end

  [x.to_i, y.to_i]
end

def update_board(board, player, row, col)
  board[row][col] = player
end

def full_turn(player, board, choice = 0)
  choice_board, max_choice = show_choices(board.clone.map(&:clone))
  puts "\nIt is #{player}'s turn:\n\n"
  print_board(choice_board)
  choice = choice.between?(1, max_choice) ? 0 : get_choice(max_choice)
  clear
  x, y = find_cell(choice_board, choice)
  update_board(board, player, x, y)
  print_board(board)
  max_choice
end

def check_winner(player, board)
  (0..2).each do |dex|
    check_sum_x = 0
    check_sum_y = 0

    (0..2).each do |val|
      check_sum_y += 1 if board[val][dex] == player
      check_sum_x += 1 if board[dex][val] == player
    end

    return player if check_sum_y == 3 || check_sum_x == 3
  end

  ''
end

def check_diag_winner(player, board)
  if board[1][1] == player
    return player if board[0][0] == player && board[2][2] == player
    return player if board[0][2] == player && board[2][0] == player
  end

  ''
end

def add_grid(board)
  (0..2).each do |val|
    board[val] = board[val].insert(1, ' | ')
    board[val] = board[val].insert(3, ' | ')
  end
end

def remove_grid(board)
  (0..2).each do |val|
    board[val].delete(' | ')
  end
end

clear
until turn_num == 1
  player = player == 'X' ? 'O' : 'X'
  turn_num = full_turn(player, board)
  remove_grid(board)
  if [check_winner(player, board), check_diag_winner(player, board)].include?(player)
    puts "\nCongratulations, #{player}, you won!"
    break
  end
  add_grid(board)
  puts "\nTic Tac Toe isn't really a game.." if turn_num == 1
end
