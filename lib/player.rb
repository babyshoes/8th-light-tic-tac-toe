require_relative 'AI.rb'
class Player
  include AI
  attr_reader :type, :name
  attr_accessor :icon, :status, :board, :choice, :scores, :moves

  HUMAN = 0
  COMPUTER = 1
  #EZCOMP = 1, MEDCOMP = 2, HARDCOMP = 3

  # should playeres own squares????

  @@all = []

  def initialize(name, board, type)
    @name = name
    @board = board
    @type = type
    @status = 'playing'
    @scores = []
    @moves = []
    @@all << self
  end

  def move
    type == HUMAN ? human_move : comp_move
  end

  def human_move
    puts "What's your move? [0-8]"
    pick_square
  end

  def pick_square
    id = gets.chomp.to_i
    (0..8).include? id && board.squares[id].occupied ? human_move : occupy_square(id)
  end

  def occupy_square(id, player = self, board_state = board)
    board_state.squares[id].occupied = player.icon
    board_state.turn_num += 1
  end

  def comp_move
    eval_board
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
      spot = choice.number
    # end
    occupy_square(spot)
    puts "#{name} took spot #{spot}."
  end

  def score(board, depth)
    if !board.tie
      return board.winner == self ? 100 - depth : depth - 100
    else
      return 0
    end
  end

  def minimax(board_state, depth = 0)
    return score(board_state, depth) if board_state.game_is_over || board_state.game_is_won
    depth += 1
    # scores = []
    # moves = []
    board_state = board_state.make_copy
    # binding.pry
    board_state.available_spaces.each do |possible_move|
      binding.pry
      player = depth.even? ? self.opponent : self
      occupy_square(possible_move.number, player, board_state)
      scores.push minimax(board_state, depth)
      moves.push possible_move
      binding.pry
    end
    binding.pry
    if (board_state.turn_num + @@all.index(self)).even?
      max_index = scores.each_with_index.max[1]
      @choice = moves[max_index]
      # binding.pry
      return scores[max_index]
    else
      min_index = scores.each_with_index.min[1]
      @choice = moves[min_index]
      # binding.pry
      return scores[min_index]
    end
  end

  def get_best_move
    minimax(board)
    binding.pry
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

  # def get_ok_move
  #if any of the winning combos has all 3 of the same thing, then inspect if
  #comp can win
  #then, if comp can block a win
  # end

end
