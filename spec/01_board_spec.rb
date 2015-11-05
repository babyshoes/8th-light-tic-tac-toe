describe 'Board' do
  describe '.new' do
    let(:board) {Board.new}
    it 'initializes with a turn number of 0' do
      expect(board.turn_num).to eq(0)
    end

    it 'initializes with an array of squares' do
      expect(board.squares).to be_a Array
      expect(board.squares.length).to eq(9)
      expect(board.squares[0]).to be_a Square
    end

    describe '#make_copy' do
      it 'makes an independent copy of every square' do
        #expect copy to eq original
        #expect 
      end
    end
  end
end
