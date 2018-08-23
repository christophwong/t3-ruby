require 'minitest/autorun'
require_relative '../lib/board.rb'

class TestBoard < Minitest::Test
  def setup
    @ui = Minitest::Mock.new
    @board = Board.new
  end

  def test_display_board_outputs_board
    @ui.expect(:give, true, [/(\d[\|\n]?){9}/])
    @board.display_board(@ui)

    @ui.verify
  end

  # def test_board_checks_returns_play
  #   assert_equal @board.check, :PLAY
  # end

  # def test_board_checks_returns_winner_when_won
  #   winning_board = Board.new([1,2,3,4,5,6,"X","X","X"])
  #   assert_equal winning_board.check, :X
  # end
end
