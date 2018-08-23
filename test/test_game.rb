require 'minitest/autorun'
require_relative '../lib/game.rb'

class TestGame < Minitest::Test
  def setup
  	@ui = Minitest::Mock.new
    @board = Minitest::Mock.new
  	@game = Game.new(@ui, @board)
  end

  def test_start_game_welcomes_player_and_display_board
    @ui.expect(:give, true, [/Welcome/, @ui])
    @board.expect(:displayBoard, true, [@ui])
    @game.start
    @ui.verify
    @board.verify
  end
end
