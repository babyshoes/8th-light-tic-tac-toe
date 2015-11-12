require 'stringio'
describe 'Player' do
  before(:each) { Player.class_variable_set :@@all, [] }
  let(:session) {
    s = CLI.new
    s.game = Game.new
    s.game.player1 = Player.new(s.game.board, {name: "Diane", type: 0, icon: s.icons[0], status: 1})
    s.game.player2 = Player.new(s.game.board, {name: "Not Diane", type: 3, icon: s.icons[1], status: 0})
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
      expect(STDOUT).to receive(:puts).with("What's your move? Select available square number.")
      allow(session.game.player1).to receive(:gets).and_return('0')
      session.game.player1.move
      expect(session.game.board.turn_num).to eq(1)
    end

    context 'if type is human'
      describe '#human_move'
        it "moves player's icon to specified square" do
          expect(STDOUT).to receive(:puts).with("What's your move? Select available square number.")
          allow(session.game.player1).to receive(:gets).and_return('4')
          session.game.player1.human_move
          expect(session.game.board.squares).to eq([[0, 1, 2], [3, 'x', 5], [6, 7, 8]])
        end


    context 'if type is perfect AI'
      describe '#minimax'
        it 'scores board correctly' do
          session.game.board.squares = [["o", "x", "o"], ["x", "x", "o"], [6, 7, 8]]
          expect(session.game.player2.minimax(session.game.board, session.game.player2)).to eq(99)
        end

      describe '#comp_move'
        it 'chooses winning move when available' do
          session.game.board.squares = [["o", "x", "o"], ["x", "x", "o"], [6, 7, 8]]
          expect(STDOUT).to receive(:puts).with("Not Diane took spot 8.")
          session.game.player2.comp_move
          expect(session.game.board.squares).to eq([["o", "x", "o"], ["x", "x", "o"], [6, 7, "o"]])
        end

    context 'if type is medium-difficulty AI'
      describe '#comp_move'
        it 'will prioritize winning if given the immediate option' do
          session.game.player2 = Player.new(session.game.board, {name: "Not Diane", type: 2, icon: session.icons[1], status: 0})
          session.game.board.squares = [["o", "x", "o"], ["x", "x", "o"], [6, 7, 8]]
          expect(STDOUT).to receive(:puts).with("Not Diane took spot 8.")
          session.game.player2.comp_move
          expect(session.game.board.squares).to eq([["o", "x", "o"], ["x", "x", "o"], [6, 7, "o"]])
        end
        it 'will block the other player from winning' do
          session.game.player2 = Player.new(session.game.board, {name: "Not Diane", type: 2, icon: session.icons[1], status: 0})
          session.game.board.squares = [["x", "o", "x"], ["o", "o", "x"], [6, 7, 8]]
          expect(STDOUT).to receive(:puts).with("Not Diane took spot 7.")
          session.game.player2.comp_move
          expect(session.game.board.squares).to eq([["x", "o", "x"], ["o", "o", "x"], [6, "o", 8]])
        end

end
