describe 'Board' do
  let(:board) {Board.new}
  let(:larger_board) {Board.new(6)}
  describe '.new' do
    it 'initializes with a turn number of 0' do
      expect(board.turn_num).to eq(0)
    end

  context 'it initializes with a regular multidimensional array of squares, where number of rows equals length of individual row'
    it 'defaults to a 3x3' do
      expect(board.squares).to be_a Array
      expect(board.squares.length).to eq(board.dimension)
      expect(board.squares.first.length).to eq(board.dimension)
    end
    it 'can be customized to larger boards' do
      expect(larger_board.squares).to be_a Array
      expect(larger_board.squares.length).to eq(larger_board.dimension)
      expect(larger_board.squares.first.length).to eq(larger_board.dimension)
    end
  end

  # context 'win conditions'
  #   describe '#game_is_over' do
  #     let(:board) {Board.new}
  #     let(:full_board) {
  #       full_board = Board.new
  #       full_board.squares =
  #     }
  #   end
end
