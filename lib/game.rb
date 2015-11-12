class Game
  attr_accessor :board, :players, :player1, :player2
  def initialize
    @board = Board.new
    @players = []
    board.game = self
  end

  # TODO: make render pretty with dimensions above 3x3
  # and display numbers are double digits
  def render_board
    i = 0
    while i < board.dimension
      puts """
      #{render_row(i)} """
      i += 1
    end
  end

  def render_row(index)
    row = board.squares[index]
    row = row.map.each_with_index do |square, i|
      square_str = "#{square}"
      square_str << " | " unless i == row.length - 1
      square_str
    end
    row.join
  end

  def play
    get_active_player.move
    switch_active_player
    puts render_board
  end

  def get_active_player
    players.find {|player| player.status == ACTIVE}
  end

  def switch_active_player
    players.each {|player| player.change_status}
  end

  def start
    puts render_board
    play until board.game_is_over
  end

end
