describe 'Player' do
  let(:game) {
    g = Game.new
    g.player1 = Player.new("Diane", g.board, 0)
    g.player2 = Player.new("Not Diane", g.board, 1)
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
    describe '#move' do

    end

end
