describe 'Game' do
  before(:each) { Player.class_variable_set :@@all, [] }
  let(:session) {
    s = CLI.new
    s.game = Game.new
    s.game.player1 = Player.new(s.game.board, {name: "Diane", type: 0, icon: s.icons[0], status: 1})
    s.game.player2 = Player.new(s.game.board, {name: "Not Diane", type: 1, icon: s.icons[1], status: 0})
    s.game.players.push(s.game.player1, s.game.player2)
    s.game.board.squares = [["O", "X", "O"], ["X", "X", "O"], [6, 7, 8]]
    s
  }

  describe '#get_active_player'
    it 'finds single player whose status is active' do
      expect(session.game.get_active_player).to eq(session.game.player2)
    end

  describe '#switch_active_player'
    it "switches both players' status" do
      expect(session.game.player1.status).to eq(1)
      expect(session.game.player2.status).to eq(0)
      session.game.switch_active_player
      expect(session.game.player1.status).to eq(0)
      expect(session.game.player2.status).to eq(1)
    end

end
