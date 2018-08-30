require 'minitest/autorun'
require_relative '../lib/board.rb'
class TestBoard < Minitest::Test
  def test_baord_defaults_to_empty_state
    board = Board.new
    assert_equal Array.new(9), board.state
  end

  def test_board_state_can_be_updated
    board = Board.new
    new_state = [
      nil, nil, nil,
      nil, nil, nil,
      nil, nil, "X"
    ]
    board.state = new_state

    assert_equal "X", board.state[8]
  end
end
