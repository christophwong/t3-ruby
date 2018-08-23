require 'minitest/autorun'
require_relative '../lib/game_runner.rb'

class TestGameRunner < Minitest::Test
  def test_game_runner_continues_running_if_game_is_not_over
    @game = Minitest::Mock.new
    @game.expect(:welcome, nil)
    @game.expect(:game_over?, false)
    @game.expect(:next_move, nil)
    @game.expect(:game_over?, true)
    @game.expect(:end, nil)
    GameRunner.run(@game)
    @game.verify
  end
end
