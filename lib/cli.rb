require_relative 'input.rb'

class CLI
  include Input
  attr_reader :players_info
  attr_accessor :game, :score, :player1_params, :player2_params

  ACTIVE = 0
  WAITING = 1

  def initialize
    @score = {}
    @player1_params = {name: "Player 1", type: 0, icon: icons[0], status: ACTIVE}
    @player2_params = {name: "Player 2", type: 3, icon: icons[1], status: WAITING}
    @players_info = [@player1_params, @player2_params]
  end

  def start_menu
    welcome
    @game = Game.new
    puts game.render_board
    instructions
    if !skip_setup?
      pick_players
      redo_input?
    end
    create_players
    play_game
  end

  def welcome
    puts greetings.sample
  end

  def greetings
    ["Welcome to Tic Tac Toe", "Howdy! Let's play.", "Ready to rumble?"]
  end

  def play_game
    game.start
    end_message
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

  def pick_players
    inquiry(player1_params)
    inquiry(player2_params)
  end

  def inquiry(player)
    puts "Tell me about #{player[:name]}."
    pick_name(player)
    pick_type(player)
    if player == player1_params
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

  def player_types
    ["human", "machine", "slightly smarter machine", "machine overlord"]
  end

  def pick_icon(player)
    puts "#{player[:name]} will be represented by: [select number]"
    icons.each_with_index {|icon, i| puts "#{i + 1}. #{icon}"}
    input = get_input.to_i
    if input < 1 || input > 2
      catch_user_error {pick_icon(player)}
    else
      player[:icon] = input == 1 ? icons[0] : icons[1]
      @player2_params[:icon] = player1_params[:icon] == icons[0] ? icons[1] : icons[1]
    end
  end

  def icons
    ["x", "o"]
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

  def display_players_info
    first_player = players.find {|player| player[:status] == 'active'}
    second_player = players.find {|player| player != first_player}
    puts "#{first_player[:name]}, a #{first_player[:type]}, is up first, playing #{first_player[:icon]}."
    puts "#{second_player[:name]}, a #{second_player[:type]}, is up next, playing #{second_player[:icon]}."
    puts "\n"
  end

  def redo_input?
    puts "Last chance! Is the following information correct? [y/n]"
    display_players_info
    input = get_input.downcase
    if input == 'n'
      pick_players
    elsif input != 'y'
      catch_user_error {redo_input?}
    end
  end

  def create_players
    game.player1 = Player.new(game.board, player1_params)
    game.player2 = Player.new(game.board, player2_params)
    game.players.push(game.player1, game.player2)
  end

  def play_again?
    puts "Play again? [y/n]"
    input = get_input.downcase
    if input == 'y'
      play_again
    elsif input == 'n'
      goodbye
    else
      catch_user_error {play_again?}
    end
  end

  def play_again
    @game = Game.new
    same_players?
    play_game
  end

  def same_players?
    puts "Same players? [y/n]"
    input = get_input.downcase
    if input == 'y'
      create_players
    elsif input == 'n'
      pick_players
    else
      catch_user_error {same_players?}
    end
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
