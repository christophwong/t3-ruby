require 'minitest/autorun'
require_relative '../lib/game.rb'

class TestGame < Minitest::Test
  def setup
    @player = "X"
  	@ui = Minitest::Mock.new
    @board = Minitest::Mock.new
    @game = Game.new(@ui, @board, @player)

  end

  def test_welcome_outputs_to_player
    @ui.expect(:give, nil, [/Welcome/])
    @game.welcome
    @ui.verify
  end

  def test_checks_if_game_is_over
    @board.expect(:check_for_winner, true)
    assert @game.game_over?
  end

  def test_next_move_displays_board_and_receives_move_from_input
    dummy_input = '1'

    @board.expect(:display_board, nil, [@ui])
    @ui.expect(:receive, dummy_input)
    @board.expect(:update, nil, [dummy_input, @player])
    @game.next_move
    @ui.verify
    @board.verify
  end

  def test_game_next_move_only_updates_player_when_update_was_successful
    @board.expect(:display_board, nil, [@ui])
    @board.expect(:display_board, nil, [@ui])
    @board.expect(:display_board, nil, [@ui])
    @ui.expect(:receive, '1')
    @ui.expect(:receive, '1')
    @ui.expect(:receive, '2')
    @board.expect(:update, true, ['1', "X"])
    @board.expect(:update, false, ['1', "O"])
    @board.expect(:update, true, ['2', "O"])
    @game.next_move
    @game.next_move
    @game.next_move
  end

  def test_game_ends_display_who_won_and_says_bye
    winner_name = "Not a loser"
    winner_pattern = Regexp.new(winner_name)
    @board.expect(:display_board, nil, [@ui])
    @board.expect(:winner, winner_name)
    @ui.expect(:give, nil, [winner_pattern])
    @ui.expect(:give, nil, [/Bye/])
    @game.end
    @ui.verify
    @board.verify
  end
end
