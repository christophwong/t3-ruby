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

  def test_board_checks_returns_play
    assert_equal @board.check, :PLAY
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
end
