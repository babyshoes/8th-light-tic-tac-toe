module AI
  attr_accessor :choice

  def dire_conditions_move
  win_immediately = []
  block_win = []
  board.available_spaces.each do |possible_move|
    board_state = board.make_copy
    occupy_square(possible_move, self, board_state)
    if board_state.game_is_won
      if board_state.winner == self.icon
        win_immediately << possible_move
      else
        block_win << possible_move
      end
    end
  end
    @choice = win_immediately.any? ? win_immediately.sample : block_win.sample
  end

  def get_ok_move
    dire_conditions_move
    get_random_move if !choice
  end

  def get_random_move
    @choice = board.available_spaces.sample
  end

  def score(board, depth)
    if board.game_is_won
      return Player.find_by(board.winner).status == ACTIVE ? FULL_SCORE - depth : depth - FULL_SCORE
    else
      return TIE_SCORE
    end
  end

  def minimax(board, player, depth = 0, scored_moves = {})
    return score(board, depth) if board.game_is_over
    depth += 1
    board.available_spaces.each do |possible_move|
      board_state = board.make_copy
      occupy_square(possible_move, player, board_state)
      scored_moves[possible_move] = minimax(board_state, player.opponent, depth)
    end
    @choice, best_score = best_move(player, scored_moves)
    best_score
  end

  def get_best_move
    x = minimax(board, self)
  end

  def best_move(player, scored_moves)
    if player.status == ACTIVE
      scored_moves.max_by { |k,v| v }
    else
      scored_moves.min_by { |k,v| v }
    end
  end


end
