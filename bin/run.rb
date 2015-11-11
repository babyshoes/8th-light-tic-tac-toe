require_relative '../config/environment.rb'

session = CLI.new
# game.board.squares = [["o", "x", "o"], ["x", "x", "o"], [6, 7, 8]]
session.start_menu
