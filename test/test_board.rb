require 'minitest/autorun'
require_relative '../lib/board.rb'

class TestBoard < Minitest::Test
  def setup
    @ui = Minitest::Mock.new
    @board = Board.new
  end

  def test_display_board_outputs_board
    @ui.expect(:give, nil, [/(\d[\|\n]?){9}/])
    @board.display_board(@ui)

    @ui.verify
  end

  def test_board_updates
    @board.update('1', "S")
    assert_equal "S", @board.board[0]
  end

  def test_board_cannot_update_the_same_grid_twice
    @board.update('1', "A")
    @board.update('1', "B")
    assert_equal @board.board[0], "A"
  end

  def test_board_checks_for_row_wins
    winning_board = [1, 2, 3, "O", "O", 6, "X", "X", "X"]
    board = Board.new(winning_board)
    assert board.check_for_winner
    assert_equal 9, board.length
  end


  def test_board_checks_for_column_wins
    winning_board = [1, 2, "X", "O", "O", "X", 7, 8, "X"]
    board = Board.new(winning_board)
    assert board.check_for_winner
    assert_equal 9, board.length
  end

  def test_board_checks_for_diagonal_wins
    winning_board = [1, 2, "X", "O", "X", "O", "X", 8, 9]
    board = Board.new(winning_board)
    assert board.check_for_winner
    assert_equal 9, board.length
  end
end
