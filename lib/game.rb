#view
class Game
  attr_accessor :board, :turn_num, :players, :player1, :player2, :winner
  def initialize
    @board = Board.new
    @turn_num = 0
    @players = [@player1, @player2]
    @winner = nil
  end

  def greetings
    ["Welcome to my Tic Tac Toe game", "Howdy! Let's play.", "Ready to rumble?"]
  end

  def welcome
    puts greetings.sample
  end

  def pick_players
    puts "First player is:"
    player_types.each_with_index {|type, i| p "#{i}. #{type}"}
    @player1 = Player.new(board, gets.chomp.to_i)
    puts "Second player is:"
    player_types.each_with_index {|type, i| p "#{i}. #{type}"}
    @player2 = Player.new(board, gets.chomp.to_i)
    representation_choices
  end

  def player_types
    ["man", "machine"]
  end

  def representations
    ["x", "o"]
  end

  def representation_choices
    puts "First player will be represented by: "
    representations.each_with_index {|icon, i| p "#{i}. #{icon}"}
    pick_representation
  end

  def pick_representation
    choice = gets.chomp
    if representations.include? choice.downcase
      @player1.icon = choice.downcase
      @player2.icon = representations.index(choice) == 0 ? representations[1] : representations[0]
    elsif choice == "0" || choice == "1"
      @player1.icon = representations[choice.to_i]
      @player2.icon = choice.to_i == 0 ? representations[1] : representations[0]
    else
      representation_choices
    end
  end

  def render_board
    """
      #{render_square(0)}|#{render_square(1)}|#{render_square(2)}
      #{render_square(3)}|#{render_square(4)}|#{render_square(5)}
      #{render_square(6)}|#{render_square(7)}|#{render_square(8)}
    """
  end

  def render_square(i)
    board.squares[i].occupied ? board.squares[i].occupied : board.squares[i].number
  end

  def start_game
    welcome
    puts render_board
    pick_players
    until board.game_is_over || board.tie
      play
      render_board
    end
    puts "Game over"
  end

  def play
      @turn_num.even? ? player1.move : player2.move
      @turn_num += 1
  end

end
