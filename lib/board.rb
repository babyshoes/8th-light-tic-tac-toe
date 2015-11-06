class Board
  attr_accessor :squares, :turn_num, :copy, :winner

  def initialize(squares = [], turn_num = 0)
    @squares = squares
    @turn_num = turn_num
    populate_board if squares.empty?
  end

  def horizontal_win
    binding.pry
    squares.any? {|row| row[0].occupied && row[0].occupied == row[1].occupied && row[1].occupied == row[2].occupied}
  end

  # make row num flexible too?
  def vertical_win
    index = 0
    win = false
    while index < squares.first.length
      win = true if squares[0][index].occupied &&
                    squares[0][index].occupied == squares[1][index].occupied &&
                    squares[1][index].occupied == squares[2][index].occupied
      index += 1
    end
    win
  end

  def diagonal_win
    win = false
    first_index = 0
    last_index = squares.first.length - 1
    if squares[0][first_index].occupied
      win = true if squares[0][first_index].occupied == squares[1][first_index + 1] &&
                    squares[1][first_index + 1].occupied == squares[2][first_index + 2]
    elsif squares[0][last_index].occupied
      win = true if squares[0][last_index].occupied == squares[1][last_index - 1] &&
                    squares[1][last_index - 1].occupied == squares[2][last_index - 2]
    end
    win
  end

  def populate_board
    (0..2).each do |time|
      squares << populate_row(time)
    end
  end

  def populate_row(i)
    row = []
    (0..2).each do |num|
      row << Square.new(num + i * 3)
    end
    row
  end

  def game_is_over
    squares.all? { |row| row.all? {|square| square.occupied } }
  end

  def game_is_won
    horizontal_win || vertical_win || diagonal_win
  end

  def tie
    game_is_over && !game_is_won
  end

  def make_copy
    copy_of_squares = self.squares.map {|row| row.map {|square| square.dup}}
    Board.new(copy_of_squares, self.turn_num)
  end

  def available_spaces
    squares.flatten.select { |square| !square.occupied }
  end

  def available_corners
    corners = [squares[0], squares[2], squares[6], squares[8]]
    corners.select { |square| !square.occupied }
  end
end
