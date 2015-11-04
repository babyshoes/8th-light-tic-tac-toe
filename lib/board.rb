class Board
  attr_accessor :squares, :possible_future

  def initialize(squares = [])
    @squares = squares
    populate_board
  end

  def winning
    [ [squares[0], squares[1], squares[2]],
      [squares[3], squares[4], squares[5]] ]
  end

  def populate_board
    (0..8).each do |num|
      squares << Square.new(num)
    end
  end

  def game_is_over
    winning.any? do |combo|
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
    squares.all? { |square| square.occupied }
  end

  def corners
    [0, 2, 6, 8]
  end

  def possible_future
    @possible_future ||= Board.new(self.squares.clone)
  end

  def available_spaces
    squares.select { |square| !square.occupied }
  end
end
