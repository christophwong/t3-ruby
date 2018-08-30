require 'minitest/autorun'
require_relative '../lib/game_runner.rb'

class TestGameRunner < Minitest::Test
  def setup
    @game = Minitest::Mock.new
    @ui = Minitest::Mock.new
    @runner = GameRunner.new(@game, @ui)
  end

  def teardown
    @game.verify
  end

  def game_loop_expects
    @game.expect(:display_board, nil)
    @game.expect(:take_human_turn, nil)
    @game.expect(:take_computer_turn, nil)
  end

  def test_can_initialize_game_runner_without_input
    assert GameRunner.new
  end

  def test_game_runner_ends_game_when_over
    @game.expect(:display_welcome, nil)
    @game.expect(:over?, false)
    game_loop_expects
    @game.expect(:over?, true)
    @game.expect(:end, nil)
    @runner.start
  end

  def test_game_runner_runs_game_until_over
    @game.expect(:display_welcome, nil)
    @game.expect(:over?, false)
    game_loop_expects
    @game.expect(:over?, false)
    game_loop_expects
    @game.expect(:over?, true)
    @game.expect(:end, nil)
    @runner.start
  end
end
