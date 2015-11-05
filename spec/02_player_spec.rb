describe 'Player' do
  let(:game) {Game.new}
  describe '.new' do
    it 'must be initialized with a board and type' do
      expect(Player.new()).to raise_error
    end
  end

  end
end
