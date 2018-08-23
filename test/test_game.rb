require 'minitest/autorun'
require_relative '../lib/game.rb'

class TestGame < Minitest::Test
  def setup
  	@ui = Minitest::Mock.new
    @board = Minitest::Mock.new
    @game = Game.new(@ui, @board)

  end

  def test_welcome_outputs_to_player
    @ui.expect(:give, nil, [/Welcome/])
    @game.welcome
    @ui.verify
  end

  def test_checks_if_game_is_over
    @board.expect(:has_winner?, true)
    assert @game.game_over?
  end

  def test_next_move_displays_board_and_receives_move_from_input
    dummy_input = '1'

    @board.expect(:display_board, nil, [@ui])
    @ui.expect(:receive, dummy_input)
    @board.expect(:update, nil, [dummy_input])
    @game.next_move
    @ui.verify
    @board.verify
  end

  def test_game_ends_says_bye
    @ui.expect(:give, nil, [/Bye/])
    @game.end
    @ui.verify
  end
end
