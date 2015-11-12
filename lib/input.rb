module Input
  attr_accessor :game

  def get_input
    input = gets.chomp
    if input.downcase == 'h' || input.downcase == 'q' || input.downcase == 'i'
      help if input.downcase == 'h'
      goodbye if input.downcase == 'q'
      instructions if input.downcase == 'i'
      get_input
    end
    input
  end

  def catch_user_error
    puts "Sorry, I didn't catch that.\n"
    yield
  end

  def help
    puts "Enter 'h' at any time for help."
    puts "Enter 'q' at any time to quit."
    puts "Enter 'i' at any time for instructions."
    puts "Enter any key to return to where you were."
    puts "\n"
  end

  def instructions
    @game = game
    dimension = game ? game.board.dimension : "a certain number of pieces"
    puts "Get #{dimension} in a row horizontally, vertically, or diagonally. Tic tac toe, defeat your foe.\n"
    help
  end

  def goodbye
    puts farewell_message.sample
    puts "\n"
    exit
  end

  def farewell_message
    ["Come again!", "Adieu.", "Aloha.", "( >'.')> <('.'< )"]
  end


end
