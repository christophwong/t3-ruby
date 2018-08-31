require 'minitest/autorun'
require_relative '../lib/game.rb'
require_relative '../lib/computer_player.rb'
require_relative './test_helpers.rb'

class TestGame < Minitest::Test
  def make_full_board_with_mixed_marks
    TestHelpers.make_full_board_with_mixed_marks
  end

  def setup
    @player = Minitest::Mock.new
    @computer_player = Minitest::Mock.new
    @ui = Minitest::Mock.new
    @board = Minitest::Mock.new
    @game = Game.new(@player, @computer_player, @ui)
  end

  def test_game_initializes_with_empty_board
    game = Game.new()
    assert game.board.empty?
  end

  def test_game_runs_displays_welcome
    @ui.expect(:give, nil, [/Welcome/])
    @game.display_welcome
    @ui.verify
  end

  def test_game_isnt_over_with_empty_board
    @game.set_board Array.new(9)
    refute @game.over?
  end

  def test_game_is_over_when_board_is_filled
    @game.set_board make_full_board_with_mixed_marks
    assert @game.over?
  end

  def test_game_isnt_over_when_board_is_half_filled
    @game.set_board ["X", nil, nil, nil, nil, nil, "O", nil, nil]
    refute @game.over?
  end

  def test_game_is_over_when_there_is_a_win
    @game.set_board [
      "X", nil, nil,
      nil, nil, nil,
      "O", "O", "O"
    ]
    assert @game.over?
  end

  def test_game_displays_numbered_board
    @game.set_board Array.new(9)
    board_pattern = /(\d[\|\n]?){9}/
    @ui.expect(:give, nil, [board_pattern])
    @game.display_board
    @ui.verify
  end

  def test_human_turn_marks_human_player_move_on_board
    chosen_index = 0
    human_player = Minitest::Mock.new
    human_player.expect(:get_chosen_index, chosen_index)

    game = Game.new(human_player, @computer_player)
    game.set_board(Array.new(9))
    game.current_player = "X"

    game.take_human_turn

    human_player.verify

    assert_equal "X", game.board.get_cell(chosen_index)
    assert_equal "O", game.current_player
  end

  def test_computer_turn_markss_computer_player_move_on_board
    game = Game.new()
    game.take_computer_turn
    assert_equal 1, game.board.state.count("O")
  end

  def test_update_to_game_board_updates_board_state
    board = Array.new(9)
    board[0] = "X"
    @game.set_board board

    assert_equal board, @game.board.state
    board[1] = "O"
    @game.set_board board

    assert_equal board, @game.board.state
  end

  def test_end_show_winner_and_board
    @ui.expect(:give, nil, [/Winner is O/])
    @ui.expect(:give, nil, [/^X\|2\|X\nO\|O\|O\nX\|X\|9$/])

    board = [
      "X", nil, "X",
      "O", "O", "O",
      "X", "X", nil
    ]
    @game.set_board board
    @game.end
    @ui.verify
  end
end
