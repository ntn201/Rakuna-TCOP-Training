require_relative "./board"
require_relative "./piece"
require_relative "./game"
require 'set'


game = Game.new
game.play

# board = Board.new
# puts board.move_chess([6,4],[5,4]).class
# puts board.move_chess([1,3],[3,3]).class
# puts board.move_chess([0,2],[4,6]).class
# puts board.move_chess([4,6],[7,3]).class == King