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
      expect(larger_board.squares.flatten.count).to eq(larger_board.dimension * larger_board.dimension)
    end
  end

  context 'end game conditions'
    let(:full_board) {
      fb = Board.new
      fb.squares = [["O", "X", "O"], ["X", "O", "O"], ["X", "O", "X"]]
      fb
    }
    let(:missing){
      m = Board.new
      m.squares = [[0, "O", "O"], ["O", "O", "O"], ["O", "O", "O"]]
      m
    }
    let(:diagonal_win_board) {
      dwb = Board.new
      dwb.squares = [["O", "X", "X"], [3, "X", "O"], ["X", "O", "O"]]
      dwb
    }
    let(:horizontal_win_board) {
      hwb = Board.new
      hwb.squares = [["O", "O", "O"], [3, "X", "O"], [6, "O", 8]]
      hwb
    }
    let(:vertical_win_board) {
      vwb = Board.new
      vwb.squares = [["O", "X", "O"], [3, "X", "O"], ["X", "X", "O"]]
      vwb
    }

    context 'board has end game conditions'
      describe '#game_is_over'
        it 'returns true when all spaces are occupied' do
          expect(full_board.game_is_over).to eq(true)
        end
        it 'returns false if even one square can be occupied' do
          expect(missing.game_is_over).to eq(false)
        end

      describe '#game_is_won'
        it 'returns true when there is a diagonal win' do
          expect(diagonal_win_board.game_is_won).to eq(true)
        end
        it 'returns true when there is a horizontal win' do
          expect(horizontal_win_board.game_is_won).to eq(true)
        end
        it 'returns true when there is a vertical win' do
          expect(vertical_win_board.game_is_won).to eq(true)
        end
        it 'returns true even if there are unoccupied spaces' do
          expect(diagonal_win_board.game_is_won).to eq(true)
        end
        it 'returns false if all spaces are occupied but there is no winning arrangement' do
          expect(full_board.game_is_won).to eq(false)
        end

    context 'board knows its unoccupied squares'
      describe '#available_corners'
        it 'returns an empty array when there are no available corners' do
          expect(full_board.available_corners.any?).to eq(false)
        end
        it 'returns square numbers of available corners' do
          expect(horizontal_win_board.available_corners).to eq([6, 8])
        end
      describe '#available_spaces'
        it 'returns an empty array when there are no available spaces' do
          expect(full_board.available_spaces.any?).to eq(false)
        end
        it 'returns square numbers of available spaces' do
          expect(horizontal_win_board.available_spaces).to eq([3, 6, 8])
        end

    describe '#get_position'
        it 'can find a square position by its id' do
          expect(board.get_position(6)).to eq([2, 0])
          expect(larger_board.get_position(6)).to eq([1, 0])
        end

    describe '#make_copy'
      let(:board_copy) {board.make_copy}
      it 'makes a copy of the board that can be manipulated without changing the original board' do
        expect(board_copy).to_not eq(board)
        expect(board_copy.squares).to eq(board.squares)
        board_copy.squares[0][0] = 'X'
        expect(board_copy.squares).not_to eq(board)
      end

end
