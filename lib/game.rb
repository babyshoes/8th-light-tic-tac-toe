#view
class Game
  def initialize
    @board = Board.new
    @turn_num = 0
    @players = [@player1, @player2]
    @winner = nil
  end

  def welcome
    puts ["Welcome to my Tic Tac Toe game", "Howdy! XOXO", "Ready to rumble?"].sample
  end

  def pick_players
    puts "First player is: 0. man / 1. machine?"
    @player1 = Player.new(gets.chomp)
    pick_representation
    puts "Second player is: 0. man / 1. machine?"
    @player2 = Player.new(gets.chomp)
  end

  def representations
    ["x", "o"]
  end

  def show_representation_choices
    puts "Choose:"
    puts representations
    pick_representation
  end

  def pick_representation
    choice = gets.chomp.downcase
    if representations.include? choice
      @player1.icon = choice
      @player2.icon = representations.index(choice) == 0 ? representations[1] : representations[0]
    else
      show_representation_choices
    end
  end

  def render_board
  end

  def start_game
    welcome
    render board
    until board.game_is_over || board.tie
      play
      render_board
    end
    puts "Game over"
  end

  def play
      turn_num.even? ? player1.move : player2.move
      turn_num += 1
  end



end

game = Game.new
game.start_game
