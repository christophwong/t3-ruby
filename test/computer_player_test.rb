require 'minitest/autorun'
require_relative '../lib/computer_player'
require_relative './test_helpers.rb'

class TestComputerPlayer < Minitest::Test
  def setup
    @computer_player = ComputerPlayer.new
    @full_board = TestHelpers.make_full_board_with_mixed_marks
  end

  def test_cp_chose_only_available_spot
    board = @full_board.dup
    board[3] = nil
    assert_equal 3, @computer_player.get_chosen_index(board)
  end

  def test_cp_chose_winning_move
    skip("build minmax alg first")
    board = [nil, nil, "O",
             nil, nil, nil,
             nil, nil, "O"]

    assert_equal 5, @computer_player.get_chosen_index(board)
  end
end
