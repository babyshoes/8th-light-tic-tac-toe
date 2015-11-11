require_relative 'input.rb'

class CLI
  include Input
  attr_reader :players
  attr_accessor :game, :score, :player1, :player2

  ACTIVE = 0
  WAITING = 1

  def initialize
    @score = {}
    @player1 = {name: "Player 1", type: 0, icon: representations[0], status: ACTIVE}
    @player2 = {name: "Player 2", type: 3, icon: representations[1], status: WAITING}
    @players = [@player1, @player2]
  end

  def start_menu
    welcome
    @game = Game.new
    puts game.render_board
    instructions
    if !skip_setup?
      pick_players
      start_over?
    end
    create_players
    start_game
  end

  def skip_setup?
    puts "Skip user set up, go directly to game? [y/n]"
    input = get_input
    if input.downcase == 'y'
      return true
    elsif input.downcase == 'n'
      return false
    else
      catch_user_error {skip_setup?}
    end
  end

  def welcome
    puts greetings.sample
  end

  def greetings
    ["Welcome to Tic Tac Toe", "Howdy! Let's play.", "Ready to rumble?"]
  end



  def representations
    ["x", "o"]
  end

  def pick_players
    inquiry(player1)
    inquiry(player2)
  end

  def create_players
    Player.new(game.board, player1)
    Player.new(game.board, player2)
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
    puts "Is #{player[:name]} a #{player_types[player[:type]]}? [y/n]"
    input = get_input
    if input.downcase == 'n'
      puts "Ok, #{player[:name]} is: [select number]"
      display_types
      input = get_input
      if ["0", "1", "2", "3"].include? input
        player[:type] = input.to_i
      else
        catch_user_error {pick_type(player)}
      end
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
      catch_user_error {pick_icon(player)}
    else
      player[:icon] = input == 1 ? representations[0] : representations[1]
      @player2[:icon] = player1[:icon] == representations[0] ? representations[1] : representations[1]
    end
  end

  def pick_status(player)
    puts "#{player[:name]} goes first or second? [1/2]"
    input = get_input.to_i
    if input < 1 || input > 2
      catch_user_error {pick_status(player)}
    else
      player[:status] = input == 1 ? ACTIVE : WAITING
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
    play until game.board.game_is_over
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
    ["human", "machine", "slightly smarter machine", "machine overlord"]
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


  def play_again?
    puts "Play again? [y/n]"
    input = gets.chomp.downcase
    case input
    when 'y'
      play_again
    when 'n'
      goodbye
    else
      catch_user_error {play_again?}
    end
  end

  def play_again
    Player.all.clear
    @game = Game.new
    same_players?
    start_game
  end

  def same_players?
    puts "Same players? [y/n]"
    input = get_input
    if input.downcase == 'y'
      create_players
    elsif input.downcase == 'n'
      pick_players
    else
      catch_user_error {same_players?}
    end
  end

  def play
    get_active_player.move
    switch_active_player
    puts game.render_board
  end

  def get_active_player
    Player.all.find {|player| player.status == 0}
  end

  def switch_active_player
    Player.all.each {|player| player.change_status}
  end

  def end_message
    if win_icon = game.board.winner
      display(update_score(win_icon))
    else
      puts "Tied game!"
    end
    tally_wins
    play_again?
  end

  def update_score(win_icon)
    winner = Player.find_by(win_icon)
    score["#{winner.name}"] ||= {'wins' => 0, 'losses' => 0}
    score["#{winner.opponent.name}"] ||= {'wins' => 0, 'losses' => 0}
    score["#{winner.name}"]['wins'] += 1
    score["#{winner.opponent.name}"]['losses'] += 1
    winner
  end

  def display(winner)
    puts "#{winner.name} wins!"
  end

  def tally_wins
    if score.any?
      score.each { |name, games| puts "#{name} has won #{games['wins']} games." }
    else
      puts "No one has won any games yet. Get conquering! "
    end
  end


end
