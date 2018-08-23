require 'minitest/autorun'
require_relative '../lib/game_runner.rb'

class TestGameRunner < Minitest::Test
  def test_game_runner_runs_game_until_it_is_over
    @game = Minitest::Mock.new
    @game.expect(:start, nil)
    # @game.expect(:game_over?, )

    GameRunner.run(@game)
    @game.verify
  end
end
