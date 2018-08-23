require 'minitest/autorun'
require_relative '../lib/game.rb'

class TestGame < Minitest::Test
  def setup
  	@ui = Minitest::Mock.new
  	@game = Game.new(@ui)
  end

  def test_start_game_welcomes_player
    @ui.expect(:give, true, [/Welcome/, @ui])
    @game.start
    @ui.verify
  end
end