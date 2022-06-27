require_relative '../lib/connect_four'

def make_board
  board = Array.new(6, nil)
  6.times do |i|
    board[i] = Array.new(7, nil)
  end 
  board
end

describe Board do
  describe '#initialize' do
    subject(:game) { described_class.new }
    
    context 'creates the board' do
      it 'board array has six rows' do
        board = game.board
        expect(board.length).to eq(6)
      end
      it 'board array has seven columns' do
        board = game.board
        expect(board[0].length).to eq(7)
      end
    end
  end
  describe '#winner?' do
    subject(:game) { described_class.new }

    context 'Checks for horizontal winners' do
      it 'four in a row on the bottom row' do
        board_state = make_board
        board_state[0] = [nil, nil, 'x', 'x', 'x', 'x', nil]
        expect(game.winner?(board_state, 'x')).to eq('x')
      end
      it 'four not in a row on the bottom' do 
        board_state = make_board
        board_state[0] = ['x', nil, 'x', nil, 'x', 'x', nil]
        p board_state
        expect(game.winner?(board_state, 'x')).not_to eq('x')
      end
    end
    context 'check #check_diaganol' do
      it 'return false on an empty board' do
        board_state = make_board
        expect(game.check_diagonal(board_state, 'x')).to eq(false)
      end
    end

    context 'check for vertical wimmers' do
      it 'random vertical winner' do
        board_state = make_board
        start = rand(0..6)
        board_state[1][start] = 'x'
        board_state[2][start] = 'x'
        board_state[3][start] = 'x'
        board_state[4][start] = 'x'
        expect(game.winner?(board_state, 'x')).to eq('x')
      end
      it 'four but not in a row' do
        board_state = make_board
        board_state[1][1] = 'x'
        board_state[2][1] = 'x'
        board_state[3][1] = 'x'
        board_state[5][1] = 'x'
        expect(game.winner?(board_state, 'x')).not_to eq('x')
      end
    end
  end
  describe '#add_move' do
    subject(:game) { described_class.new }
    context 'check if a random move is added' do
      it 'random x move' do
        board_state = make_board
        move = rand (0..5)
        expect(game.add_move('x', move)).to eq(game.board)
      end
    end
  end

end
