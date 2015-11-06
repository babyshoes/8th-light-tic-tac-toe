require 'pry'
class Board
  attr_reader :dimension
  attr_accessor :squares, :turn_num, :copy, :winner

  def initialize(dimension = 3, squares = [], turn_num = 0)
    @dimension = dimension
    @squares = squares
    @turn_num = turn_num
    populate_board if squares.empty?
  end

  def populate_board
    dimension.times { |i| squares << make_row(i) }
  end

  def make_square(row_num, i)
    (row_num * dimension) + i
  end

  def make_row(id)
    row = []
    dimension.times { |i| row << make_square(id, i)}
    row
  end

  def horizontal_win
    squares.find do |row|
      row.uniq.length == 1
    end
  end

  def vertical_win
    squares.first.each_with_index.find do |square, y|
      squares_to_compare = []
      dimension.times {|x| squares_to_compare << squares[x][y]}
      squares_to_compare.uniq.length == 1
    end
  end

  # CALLBACK HERE?
  def diagonal_win
    diagonal_win_right || diagonal_win_left
  end

  def diagonal_win_right
    squares_to_compare = []
    dimension.times {|x| squares_to_compare << squares[x][x]}
    squares_to_compare.uniq.length == 1
  end

  def diagonal_win_left
    squares_to_compare = []
    dimension.times {|x| squares_to_compare << squares[x][dimension - x - 1]}
    squares_to_compare.uniq.length == 1
  end

  def game_is_over
    squares.all? { |row| row.all? {|square| square.is_a? String } }
  end

  def game_is_won
    !!diagonal_win || !!vertical_win || !!horizontal_win
  end

  def tie
    game_is_over && !game_is_won
  end

  def make_copy
    copy_of_squares = squares.map {|row| row.map {|square| square.dup}}
    Board.new(board.copy_of_squares, board.turn_num)
  end

  def available_spaces(set)
    set.select { |square| !square.occupied }
  end

  def available_corners
    corners = [squares[0][0], squares[0][dimension - 1], squares[dimension - 1][0], squares[dimension - 1][dimension - 1]]
    available_spaces(corners)
  end
end
