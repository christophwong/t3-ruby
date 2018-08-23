require_relative "game.rb"
require_relative "ui.rb"
require_relative "board.rb"

class GameRunner
  def self.run(game = Game.new(UI.new, Board.new))
    game.start
  end
end
