describe 'Player' do
  before(:each) { Player.class_variable_set :@@all, [] }
  let(:session) {
    s = CLI.new
    s.game = Game.new
    s.game.player1 = Player.new(s.game.board, {name: "Diane", type: 0, icon: s.icons[0], status: 1})
    s.game.player2 = Player.new(s.game.board, {name: "Not Diane", type: 1, icon: s.icons[1], status: 0})
    s.game.players.push(s.game.player1, s.game.player2)
    s
  }
  let(:fake_session){
    s = CLI.new
    s.game = Game.new
    s.game.player1 = Player.new(s.game.board, {name: "Fake", type: -1, icon: 'f', status: 0})
    s.game.player2 = Player.new(s.game.board, {name: "Faker", type: 3, icon: 'x', status: 1})
    s
  }
  let(:player) {Player.new}
  describe '.new' do
    it 'must be initialized with a board and player hash' do
      expect{Player.new}.to raise_error(ArgumentError)
    end
    it 'has a name' do
      expect(session.game.player1.name).to eq("Diane")
      expect(session.game.player2.name).to eq("Not Diane")
    end
    it 'has a type in numerical form' do
      expect([*0..session.player_types.length].include? session.game.player1.type).to eq(true)
      expect([*0..session.player_types.length].include? session.game.player2.type).to eq(true)
      expect([*0..session.player_types.length].include? fake_session.game.player1.type).to eq(false)
    end
    it 'has a type' do
      expect(session.game.player1.type).to eq(0)
      expect(session.game.player2.type).to eq(3)
    end
    it 'has an icon different from its opponent' do
      expect(session.icons.include? session.game.player1.icon).to eq(true)
      expect(session.icons.include? session.game.player2.icon).to eq(true)
      expect(session.game.player1.icon != session.game.player2.icon).to eq(true)
    end
    it 'has a play status different from its opponent' do
      expect(session.game.player1.status != session.game.player2.icon).to eq(true)
    end

  end

  describe "#opponent"
    it "selects the other player as this player's opponent" do

      expect(session.game.player1.opponent).to eq(session.game.player2)
      expect(session.game.player1.opponent).not_to eq(session.game.player1)
      expect(session.game.player1.opponent.opponent).to eq(session.game.player1)
    end

  describe "#move"
    it 'increases turn count' do
      expect(session.game.board.turn_num).to eq(0)
      session.game.player2.move
      expect(session.game.board.turn_num).to eq(1)
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
        it 'will always choose the wi' do
        # game.board.squares = [["O", "X", "O"], ["X", "X", "O"], [6, 7, 8]]
        # if comp is "X", it will move to 7. If it is "O", it will move to 8.
        end

    context 'if type is medium-difficulty AI'
      describe '#medium_move'
        it 'will prioritize winning if given the immediate option' do

        end
        it 'will block the other player from winning' do

        end
        it 'otherwise picks move randomly' do

        end

end
