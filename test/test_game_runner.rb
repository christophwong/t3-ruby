require 'minitest/autorun'
require_relative '../lib/game_runner.rb'

class TestGameRunner < Minitest::Test
  def test_start_script_calls_start_game
    @game = Minitest::Mock.new
    @game.expect(:start, nil)

    GameRunner.run(@game)
    @game.verify
  end
end
