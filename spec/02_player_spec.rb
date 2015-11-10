describe 'Player' do
  # do i need to clear Player.all in between games??
  before(:each) { Player.class_variable_set :@@all, [] }
  let(:game) {
    g = Game.new
    g.player1 = Player.new("Diane", g.board, 0)
    g.player1.icon = 'X'
    g.player2 = Player.new("Not Diane", g.board, 1)
    g.player2.icon = 'O'
    g
  }
  let(:player) {Player.new}
  describe '.new' do
    it 'must be initialized with a board and type' do
      expect{Player.new}.to raise_error(ArgumentError)
    end
    it 'has a type' do
      expect(game.player1.type).to eq(0)
      expect(game.player2.type).to eq(1)
    end
  end

  describe '#opponent'
    it "selects the other player as this player's opponent" do
      expect(game.player1.opponent).to eq(game.player2)
      expect(game.player1.opponent).not_to eq(game.player1)
      expect(game.player1.opponent.opponent).to eq(game.player1)
    end

  context 'if type is human'
    let(:input) {'4'}
    describe '#human_move'
      xit "moves player's icon to specified square" do
        allow(STDOUT).to receive(:puts) {"What's your move? Select available square number."}
        expect(game.player1.pick_square).to eq(true)
        allow(STDIN).to receive(:gets) {'4'}
        expect(game.board.squares).to eq([[0, 1, 2], [3, "X", 5], [6, 7, 8]])
      end

  context 'if type is perfect AI'
    describe '#move'
      it ''
      # game.board.squares = [["O", "X", "O"], ["X", "X", "O"], [6, 7, 8]]
      # if comp is "X", it will move to 7. If it is "O", it will move to 8.
    end

  context 'if type is medium-difficulty AI'
    describe '#move'
      it 'will prioritize winning if given the immediate option' do

      end
      it 'will block the other player from winning' do

      end
      it 'otherwise plays like the easy-difficulty AI' do

      end

end
