class CLI
  attr_reader :game
  # where to start new game
  # keeps score
  # help menu

  def initialize
    @game = Game.new
    @score
  end

  def help
    "Your mission is simple. Get #{game.board.dimension} in a row horizontally, vertically, or diagonally. Defeat your foe."
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
    display_types(0, 1)
    choice = gets.chomp.downcase
    if choice[0] == 'm'
      if choice == 'man'
        return 0
      elsif choice == 'machine'
        pick_difficulty_level
      else
        binding.pry
        catch_user_error(pick_type)
      end
    elsif choice == "0" || choice == "1" || choice == "2" || choice == "3"
      return choice.to_i
    else
      binding.pry
      catch_user_error(pick_type)
    end
  end

  def catch_user_error(block)
    binding.pry
    puts "Sorry I didn't catch that."
    block
  end

  def player_types
    ["man", "machine", "harder machine", "perfect machine"]
  end

  def pick_difficulty_level
    display_types(1, 3)
    choice = gets.chomp.downcase
    if choice == "1" || choice == "2" || choice == "3"
      return choice.to_i
    elsif player_types.include? choice
      return player_types.index(choice)
    else
      catch_user_error(pick_difficulty_level)
    end
  end


  def display_types(i, j)
    player_types[i..j].each_with_index {|type, i| puts "#{i}. #{type}"}
  end

  def representations
    ["x", "o"]
  end

  def representation_choices
    puts "First player will be represented by: "
    representations.each_with_index {|icon, i| puts "#{i}. #{icon}"}
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

  def play_again?
    #empty Player.all?
    @game = Game.new
    start_game
  end

  def start_game
    welcome
    puts game.render_board
    pick_players
    puts game.render_board
    game.play until game.board.game_is_over
    end_message
  end

  def play
    board.turn_num.even? ? player1.move : player2.move
    puts render_board
  end

  def end_message
    if game.board.winner
      puts "#{Player.find_by(game.board.winner).name} wins!"
    else
      puts "Tied game!"
    end
    play_again?
  end


end
