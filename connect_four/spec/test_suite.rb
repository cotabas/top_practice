require_relative '../lib/connect_four'

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
end
