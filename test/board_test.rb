require 'minitest/autorun'
require_relative '../lib/board.rb'
class TestBoard < Minitest::Test
  def setup
    @board = Board.new
  end

  def test_board_defaults_to_empty_state
    assert_equal Array.new(9), @board.state
  end

  def test_board_state_can_be_updated
    new_state = [
      nil, nil, nil,
      nil, nil, nil,
      nil, nil, "X"
    ]
    @board.state = new_state

    assert_equal "X", @board.state[8]
  end

  def test_board_has_nine_available_spaces
    assert_equal 9, @board.get_available_spaces.length
  end

  def test_board_has_eight_available_spaces
    @board.state[4] = "X"
    spaces = @board.get_available_spaces
    assert_equal [0, 1, 2, 3, 5, 6, 7, 8], spaces
    refute spaces.include?(4)
  end

  def test_empty_board
    assert @board.empty?

    @board.state[1] = "O"
    refute @board.empty?
  end

  def test_update_with_index
    @board.update_with_index(4, "X")
    assert_equal "X", @board.state[4]
  end

  def test_get_cell_returns_value
    @board.update_with_index(3, "X")
    assert_equal "X", @board.get_cell(3)
    assert_nil @board.get_cell(0)
  end

  def test_in_end_state_returns_true_for_O_win
    @board.state = [
      nil, nil, "X",
      nil, "X", "X",
      "O", "O", "O"
    ]
    assert @board.in_end_state?
  end

  def test_in_end_state_returns_true_for_X_win
    @board.state = [
      nil, nil, "X",
      nil, "X", "X",
      "O", "O", "X"
    ]
    assert @board.in_end_state?
  end

  def test_in_end_state_returns_true_for_draw_or_tied_game
    @board.state = [
      "X", "O", "X",
      "X", "O", "O",
      "O", "X", "X"
    ]
    assert @board.in_end_state?
  end

  def test_in_end_state_returns_false_if_there_are_available_moves
    refute @board.in_end_state?
  end

  def test_X_and_O_wins
    @board.state = [
      nil, nil, "O",
      "X", "X", "O",
      "X", nil, "O"
    ]
    refute @board.X_wins?
    assert @board.O_wins?

    @board.state = [
      nil, nil, "X",
      "X", "X", "O",
      "X", nil, "O"
    ]
    assert @board.X_wins?
    refute @board.O_wins?
  end

  def test_board_is_full
    refute @board.no_available_moves?

    @board.state = Array.new(9, "X")
    assert @board.no_available_moves?
  end

  def test_new_board_with_first_available_box_filled
    new_board = @board.new_board_with_first_available_box_filled("X")
    new_board = new_board.new_board_with_first_available_box_filled("O")

    assert_nil @board.get_cell(0)
    assert_nil @board.get_cell(1)

    assert_equal "X", new_board.get_cell(0)
    assert_equal "O", new_board.get_cell(1)
  end

  def test_winner_returns_winner
    @board.state =["X", "X", "X", nil, nil, nil, nil, nil, nil]
    assert_equal "X", @board.winner

    @board.state = ["O", "O", "O", nil, nil, nil, nil, nil, nil]
    assert_equal "O", @board.winner

    @board.state = ["X", "O", "X", nil, nil, nil, nil, nil, nil]
    assert_nil @board.winner
  end
end
