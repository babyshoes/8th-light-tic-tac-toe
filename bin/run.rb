require_relative '../config/environment.rb'

game = Game.new
# game.board.squares = [["o", "x", "o"], ["x", "x", "o"], [6, 7, 8]]
game.start_game
