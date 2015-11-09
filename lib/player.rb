require_relative 'AI.rb'
class Player
  include AI
  attr_reader :type, :name
  attr_accessor :icon, :status, :board, :scores, :moves

  HUMAN = 0
  EZ_COMPUTER = 1
  MEDIUM_COMPUTER = 2
  PERFECT_COMPUTER = 3

  # should playeres own squares????

  @@all = []

  def initialize(name, board, type)
    @name = name
    @board = board
    @type = type
    @status = 'playing'
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_by(icon)
    @@all.find{|player| player.icon == icon}
  end

  def move
    type == HUMAN ? human_move : comp_move
  end

  def human_move
    puts "What's your move? Select available square number."
    pick_square
  end

  def pick_square
    id = gets.chomp.to_i
    board.squares.flatten.include? id ? occupy_square(id) : human_move
  end

  def occupy_square(id, player = self, board_state = board)
    unless board_state.game_is_over
      coords = board_state.get_position(id)
      board_state.squares[coords.first][coords.last] = player.icon
      board_state.turn_num += 1
    end
  end

  def opponent
    @@all.index(self) == 0 ? @@all[1] : @@all[0]
  end

  def eval_board
    # if !board.squares[4].occupied
    #   spot = board.squares[4]
    # elsif board.available_corners.any?
    #   spot = board.available_corners.sample
    # else
      get_best_move
      spot = choice
    # end
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

  # def get_best_move(next_player, depth = 0, best_score = {})
  #   best_move = nil
  #   board.copy.available_spaces.each do |free_space|
  #     free_space.occupied = icon
  #     if game_is_over(board)
  #       best_move = as.to_i
  #       board[as.to_i] = as
  #       return best_move
  #     else
  #       board[as.to_i] = @hum
  #       if game_is_over(board)
  #         best_move = as.to_i
  #         board[as.to_i] = as
  #         return best_move
  #       else
  #         board[as.to_i] = as
  #       end
  #     end
  #   end
  #   if best_move
  #     return best_move
  #   else
  #     n = rand(0..available_spaces.count)
  #     return available_spaces[n].to_i
  #   end
  # end



end
