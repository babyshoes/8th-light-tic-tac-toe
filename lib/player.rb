require_relative 'AI.rb'
class Player
  include AI
  attr_reader :type
  attr_accessor :icon, :status, :board

  HUMAN = 0
  COMPUTER = 1
  #EZCOMP = 1, MEDCOMP = 2, HARDCOMP = 3

  @@all = []

  def initialize(board, type)
    @board = board
    @type = type
    @status = 'playing'
    @@all << self
  end

  def move
    type == HUMAN ? human_move : comp_move
  end

  def human_move
    puts "What's your move? [0-9]"
    pick_square
  end

  def pick_square
    id = gets.chomp.to_i
    board.squares[id].occupied ? pick_square : occupy_square(id)
  end

  def occupy_square(id)
    board.squares[id].occupied = self.icon
  end

  def comp_move
    eval_board
  end

  def opponent
    @@all.index(self) == 0 ? @@all[1] : @@all[0]
  end

  def eval_board
    spot = nil
    until spot
      if !board.squares[4].occupied
        spot = 4
      elsif available_corners?.any?
        spot = available_corners.sample
      else
        spot = get_best_move
        if !board.squares[spot].occupied
          board.squares[spot] = icon
        else
          spot = nil
        end
      end
    end
    board.squares[spot].occupied = icon
  end

  def available_corners?
    corners = [0, 2, 6, 8]
    corners.select { |n| board.squares[n].occupied }
  end

  def score(board, depth)
    if board.game_is_over
      return board.winner == self ? 100 - depth : depth - 100
    else
      return 0
    end
  end

  def minimax(depth = 0)
    
  end

  def get_best_move(next_player, depth = 0, best_score = {})
    best_move = nil
    board.possible_future.available_spaces.each do |free_space|
      free_space.occupied = icon
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end

  # def get_ok_move
  #if any of the winning combos has all 3 of the same thing, then inspect if
  #comp can win
  #then, if comp can block a win
  # end

end
