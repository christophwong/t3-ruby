require 'minitest/autorun'
require_relative '../lib/game_runner.rb'

class TestGameRunner < Minitest::Test
  def setup
    @game = Minitest::Mock.new
    @runner = GameRunner.new(@game)
  end

  def teardown
    @runner.start
    @game.verify
  end

  def test_main_flow
    game_begins
    first_turn_loop
    game_is_not_over
    second_turn_loop

    over_and_out
  end

  def test_repeat_game
    game_begins
    first_turn_loop
    game_over
    new_game
    repeat_game
  end

  def game_turn_loop
    @game.expect(:display_board, nil)
    @game.expect(:take_human_turn, nil)
    @game.expect(:take_computer_turn, nil)
  end

  def game_begins
    @game.expect(:display_welcome, nil)
    @game.expect(:over?, false)
  end

  def first_turn_loop
    game_turn_loop
  end

  def game_is_not_over
    @game.expect(:over?, false)
  end

  def second_turn_loop
    game_turn_loop
  end

  def game_over
    @game.expect(:over?, true)
    @game.expect(:end, nil)
  end

  def new_game
    @game.expect(:new_game?, true)

  end

  def repeat_game
    @game.expect(:reset_state!, nil)
    @game.expect(:start, nil)
  end

  def over_and_out
    @game.expect(:over?, true)
    @game.expect(:end, nil)
    @game.expect(:new_game?, false)
    @game.expect(:display_good_bye, nil)
  end
end
