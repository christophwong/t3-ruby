require_relative './game.rb'
require_relative './human_player.rb'
require_relative './computer_player.rb'
require_relative './ui.rb'

class GameRunner
  def initialize(game = nil, ui = nil)
    @ui = ui ||  UI.new
    @game = game || Game.new(HumanPlayer.new(@ui), ComputerPlayer.new)
  end

  def start
    @game.display_welcome

    until @game.over?
      @game.display_board
      @game.take_human_turn
      @game.take_computer_turn
    end
    @game.end

    if @game.new_game?
      @game.reset_board!
      start
    else
      @game.display_good_bye
    end
  end
end
