class CLI
  attr_reader :players
  attr_accessor :game, :score, :player1, :player2

  def initialize
    @score = {}
    @player1 = {name: "Player 1", type: player_types[0], icon: representations[0], status: 'active'}
    @player2 = {name: "Player 2", type: player_types[2], icon: representations[1], status: 'waiting'}
    @players = [@player1, @player2]
  end

  def start_menu
    welcome
    @game = Game.new
    puts game.render_board
    instructions
    pick_players
    start_over?
    start_game
  end

  def catch_user_error
    puts "Sorry I didn't catch that."
    yield
  end

  def get_input
    input = gets.chomp
    if input.downcase == 'h' || input.downcase == 'x' || input.downcase == 'i'
      help if input.downcase == 'h'
      goodbye if input.downcase == 'x'
      instructions if input.downcase == 'i'
      get_input
    end
    input
  end

  def welcome
    puts greetings.sample
  end

  def greetings
    ["Welcome to Tic Tac Toe", "Howdy! Let's play.", "Ready to rumble?"]
  end

  def help
    puts "Enter 'h' at any time for help."
    puts "Enter 'x' at any time to quit."
    puts "Enter 'i' at any time for instructions."
  end

  def instructions
    dimension = game ? game.board.dimension : "a certain number of pieces"
    puts "Get #{dimension} in a row horizontally, vertically, or diagonally. Tic tac toe, defeat your foe."
    help
  end

  def representations
    ["x", "o"]
  end

  def pick_players
    inquiry(player1)
    Player.new(game.board, player1)
    inquiry(player2)
    Player.new(game.board, player2)
    # puts "First player is:"
    # board.player1 = Player.new("Player 1", board, pick_type, 'active')
    # puts "Second player is:"
    # board.player2 = Player.new("Player 2", board, pick_type, 'waiting')
    # representation_choices
  end

  def inquiry(player)
    puts "Tell me about #{player[:name]}."
    pick_name(player)
    pick_type(player)
    if player == player1
      pick_icon(player)
      pick_status(player)
    end
  end

  def pick_name(player)
    puts "Does #{player[:name]} go by #{player[:name]}? [y/n]"
    input = get_input
    if input.downcase == 'n'
      puts "What name should we change it to?"
      player[:name] = get_input
    end
  end

  def pick_type(player)
    puts "Is #{player[:name]} a #{player[:type]}? [y/n]"
    input = get_input
    if input.downcase == 'n'
      puts "Ok, #{player[:name]} is: [select number]"
      display_types
      type = get_input
      # if type == representations
      player[:type] = type
    end
  end

  def display_types
    player_types.each_with_index {|type, i| puts "#{i}. #{type}"}
  end

  def representation_choices
    puts "First player will be represented by: "
    representations.each_with_index {|icon, i| puts "#{i}. #{icon}"}
    pick_representation
  end
  #
  # # def pick_representation
  # #   choice = gets.chomp
  # #   if representations.include? choice.downcase
  # #     player1.icon = choice.downcase
  # #     player2.icon = representations.index(choice) == 0 ? representations[1] : representations[0]
  # #   elsif choice == "0" || choice == "1"
  # #     player1.icon = representations[choice.to_i]
  # #     player2.icon = choice.to_i == 0 ? representations[1] : representations[0]
  # #   else
  # #     representation_choices
  # #   end
  # # end
  #
  def pick_icon(player)
    puts "#{player[:name]} will be represented by: [select number]"
    representations.each_with_index {|icon, i| puts "#{i + 1}. #{icon}"}
    input = get_input.to_i
    if input < 1 || input > 2
      catch_user_error {pick_icon}
    else
      player[:icon] = input == 1 ? representations[0] : representations[1]
      @player2[:icon] = player1[:icon] == representations[0] ? representations[1] : representations[1]
    end
  end

  def pick_status(player)
    puts "#{player[:name]} goes first or second? [1/2]"
    input = get_input.to_i
    if input < 1 || input > 2
      catch_user_error {pick_status}
    else
      player[:status] = input == 1 ? 'active' : 'waiting'
    end
  end

  def display_players
    first_player = players.find {|player| player[:status] == 'active'}
    second_player = players.find {|player| player != first_player}
    puts "#{first_player[:name]}, a #{first_player[:type]}, is up first, playing #{first_player[:icon]}."
    puts "#{second_player[:name]}, a #{second_player[:type]}, is up next, playing #{second_player[:icon]}."
    puts "\n"
  end

  def start_over?
    puts "Last chance! Is the following information correct? [y/n]"
    display_players
    input = get_input
    if input.downcase == 'n'
      pick_players
    elsif input.downcase != 'y'
      catch_user_error {start_over?}
    end
  end

  def start_game
    puts game.render_board
    game.play until game.board.game_is_over
    end_message
  end


  #
  # # def type
  # #   display_types(0, 1)
  # #   choice = gets.chomp.downcase
  # #   if choice[0] == 'm'
  # #     if choice == 'man'
  # #       return 0
  # #     elsif choice == 'machine'
  # #       pick_difficulty_level
  # #     else
  # #       binding.pry
  # #       catch_user_error {pick_type}
  # #     end
  # #   elsif choice == "0" || choice == "1" || choice == "2" || choice == "3"
  # #     return choice.to_i
  # #   else
  # #     binding.pry
  # #     catch_user_error {pick_type}
  # #   end
  # # end
  #
  #
  #
  def player_types
    ["human", "machine", "slightly smarter machine", "overlord machine"]
  end
  #

  #
  # def pick_difficulty_level
  #   display_types(1, 3)
  #   choice = gets.chomp.downcase
  #   if choice == "1" || choice == "2" || choice == "3"
  #     return choice.to_i
  #   elsif player_types.include? choice
  #     return player_types.index(choice)
  #   else
  #     catch_user_error(:pick_difficulty_level)
  #   end
  # end
  #
  #

  #
  # def play_again?
  #   puts "Play again? [y/n]"
  #   input = gets.chomp.downcase
  #   case input
  #   when 'y'
  #     play_again
  #   when 'n'
  #     puts goodbye.sample
  #   else
  #     catch_user_error {play_again?}
  #   end
  # end
  #
  # def goodbye
  #   ["Goodbye.", "Adieu.", "Aloha.", "( >'.')> <('.'< )"]
  # end
  #
  # def play_again
  #   Player.all.clear
  #   @game = Game.new()
  #   same_players?
  #   start_game
  # end
  #
  # def same_players?
  #   puts "Same players? [y/n]"
  #   input = gets.chomp.downcase
  #   case input
  #   when 'y'
  #
  #   when 'n'
  #     pick_players
  #   else
  #     catch_user_error {same_players?}
  #   end
  # end
  #
  def play
    get_active_player.move
    # board.turn_num.even? ? player1.move : player2.move
    # put active switcher and turn counter here?
    puts game.render_board
  end
  #
  # def get_active_player
  #   Player.all.find {|player| player.status == 'active'}
  # end
  #
  # def end_message
  #   if win_icon = game.board.winner
  #     winner = Player.find_by(win_icon)
  #     score["#{winner.name}"] ||= {'wins' => 0, 'losses' => 0}
  #     score["#{winner.opponent.name}"] ||= {'wins' => 0, 'losses' => 0}
  #     score["#{winner.name}"]['wins'] += 1
  #     score["#{winner.opponent.name}"][:losses] += 1
  #     puts "#{winner.name} wins!"
  #   else
  #     puts "Tied game!"
  #   end
  #   tally_wins
  #   play_again?
  # end
  #
  # def tally_wins
  #   if score.any?
  #     score.each { |name, games| puts "#{name} has won #{games['wins']} games." }
  #   else
  #     puts "Get conquering! No one has won yet."
  #   end
  # end


end
