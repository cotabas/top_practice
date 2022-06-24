require_relative '../lib/connect_four'

def make_board
  Array.new(6, Array.new(7, nil))
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
    context 'Checks for horizontal winners' do
      it 'four in a row on the bottom row' do
        board_state = make_board
        board_state[0] = [nil, nil, 'x', 'x', 'x', 'x', nil]
        expect(game.check_winner(board_state)).to eq('x')
      end
      it 'four not in a row on the bottom' do 
        board_state = make_board
        board_state[0] = ['x', nil, 'x', nil, 'x', 'x', nil]
        expect(game.check_winner(board_state)).not_to eq('x')
      end
    end

  end
end
