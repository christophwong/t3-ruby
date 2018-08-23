require 'minitest/autorun'
require_relative '../lib/board.rb'

class TestBoard < Minitest::Test
  def setup
    @ui = Minitest::Mock.new
    @board = Board.new
  end

  def test_display_board_outputs_board
    @ui.expect(:give, true, [/(\d[\|\n]?){9}/])
    @board.displayBoard(@ui)

    @ui.verify
  end
end
