class GameRunner
  def initialize(game)
    @game = game
  end

  def start
    @game.display_welcome

    until @game.over?
      @game.display_board
      @game.take_human_turn
      @game.take_computer_turn
    end
    @game.end
  end
end
