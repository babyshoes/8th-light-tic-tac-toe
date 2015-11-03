# view

class Board
  attr_accessor :squares
  def initialize
    @squares = []
    populate_board
  end

  def populate_board
    (0..8).each do |num|
      squares << Square.new(num)
    end
  end
end
