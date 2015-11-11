class Game
  attr_accessor :board
  def initialize
    @board = Board.new
  end


  #TODO: make render pretty when board #s are double digits
  def render_board
    i = 0
    while i < board.dimension
      puts """
      #{render_row(i)} """
      i += 1
    end

    # """
    #   #{ board.dimension.times do |i|
    #       puts render_row(i)
    #     end }
    # """

    # """
    #   #{render_square(0)}|#{render_square(1)}|#{render_square(2)}
    #   #{render_square(3)}|#{render_square(4)}|#{render_square(5)}
    #   #{render_square(6)}|#{render_square(7)}|#{render_square(8)}
    # """
  end

  def render_row(index)
    row = board.squares[index]
    row = row.map.each_with_index do |square, i|
      square_str = "#{square}"
      square_str << " | " unless i == row.length - 1
      square_str
    end
    row.join
  end





end
