require_relative 'AI.rb'
require_relative 'input.rb'

class Player
  include AI
  include Input
  attr_reader :type, :name, :icon, :board
  attr_accessor :status

  @@all = []

  def initialize(board, player_hash = {})
    @board = board
    @name = player_hash[:name]
    @type = player_hash[:type]
    @icon = player_hash[:icon]
    @status = player_hash[:status]
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_by(icon)
    Player.all.last.board.game.players.find {|player| player.icon == icon}
  end

  def change_status
    @status = status == ACTIVE ? WAITING : ACTIVE
  end

  def opponent
    players = board.game.players
    players.index(self) == 0 ? players[1] : players[0]
  end

  def comp_move
    case type
    when EZ_COMPUTER
      get_random_move
    when MEDIUM_COMPUTER
      get_ok_move
    when PERFECT_COMPUTER
      get_best_move
    end
    occupy_square(choice)
    puts "#{name} took spot #{choice}."
  end

  def move
    type == HUMAN ? human_move : comp_move
  end

  def human_move
    puts "What's your move? Select available square number."
    pick_square
  end

  def pick_square
    id = get_input
    id_num = id.to_i
    human_move if id_num == 0 && id != "0"
    board.squares.flatten.include?(id_num) ? occupy_square(id_num) : catch_user_error {human_move}
  end

  def occupy_square(id, player = self, board_state = board)
    unless board_state.game_is_over
      coords = board_state.get_position(id)
      board_state.squares[coords.first][coords.last] = player.icon
      board_state.turn_num += 1
    end
  end

end
