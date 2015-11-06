class Board
  attr_accessor :squares, :turn_num, :copy, :winner

  def initialize(squares = [], turn_num = 0)
    @squares = squares
    @turn_num = turn_num
    populate_board if squares.empty?
  end

  def winning
    [ [squares[0], squares[1], squares[2]],
      [squares[3], squares[4], squares[5]],
      [squares[6], squares[7], squares[8]],
      [squares[0], squares[3], squares[6]],
      [squares[1], squares[4], squares[7]],
      [squares[2], squares[5], squares[8]],
      [squares[0], squares[4], squares[8]],
      [squares[2], squares[4], squares[6]] ]
  end

  def populate_board
    (0..8).each do |num|
      squares << Square.new(num)
    end
  end

  def game_is_over
    squares.all? { |square| square.occupied }
  end

  def game_is_won
    winning.find do |combo|
      combo[0].occupied && combo[0].occupied == combo[1].occupied && combo[1].occupied == combo[2].occupied
    end
    # [b[0], b[1], b[2]].uniq.length == 1 ||
    # [b[3], b[4], b[5]].uniq.length == 1 ||
    # [b[6], b[7], b[8]].uniq.length == 1 ||
    # [b[0], b[3], b[6]].uniq.length == 1 ||
    # [b[1], b[4], b[7]].uniq.length == 1 ||
    # [b[2], b[5], b[8]].uniq.length == 1 ||
    # [b[0], b[4], b[8]].uniq.length == 1 ||
    # [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie
    game_is_over && !game_is_won
  end

  def make_copy
    copy_of_squares = self.squares.map {|square| square.dup}
    Board.new(copy_of_squares, self.turn_num)
  end

  def available_spaces
    squares.select { |square| !square.occupied }
  end

  def available_corners
    corners = [squares[0], squares[2], squares[6], squares[8]]
    corners.select { |square| !square.occupied }
  end
end
