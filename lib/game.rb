#view
class Game
  attr_accessor :board, :player1, :player2
  def initialize
    @board = Board.new
    # @players = [@player1, @player2]
  end

  def greetings
    ["Welcome to my Tic Tac Toe game", "Howdy! Let's play.", "Ready to rumble?"]
  end

  def welcome
    puts greetings.sample
  end

  def pick_players
    puts "First player is:"
    @player1 = Player.new("Player 1", board, pick_type)
    puts "Second player is:"
    @player2 = Player.new("Player 2", board, pick_type)
    representation_choices
  end

  def pick_type
    display_types
    choice = gets.chomp.downcase
    if choice[0] == 'm'
      if choice == 'man'
        return 0
      elsif choice == 'machine'
        return 1
      else
        puts "Sorry I didn't catch that."
        pick_type
      end
    elsif choice == "0" || choice == "1"
      return choice.to_i
    else
      puts "Sorry I didn't catch that."
      pick_type
    end
  end

  def player_types
    ["man", "machine"]
  end

  def display_types
    player_types.each_with_index {|type, i| p "#{i}. #{type}"}
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
      player1.icon = choice.downcase
      player2.icon = representations.index(choice) == 0 ? representations[1] : representations[0]
    elsif choice == "0" || choice == "1"
      player1.icon = representations[choice.to_i]
      player2.icon = choice.to_i == 0 ? representations[1] : representations[0]
    else
      representation_choices
    end
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

  def start_game
    welcome
    puts render_board
    pick_players
    puts render_board
    play until board.game_is_won || board.game_is_over
    end_message
  end

  def play
    board.turn_num.even? ? player1.move : player2.move
    puts render_board
  end

  def end_message
    if board.tie
      puts "Tied game!"
    else
      puts "#{board.winner.name} wins!"
    end
    play_again?
  end

  def play_again?
    # not good practice to open a new instance of object within?
    Game.new
  end

end
