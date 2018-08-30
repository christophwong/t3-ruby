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
    board = [
      nil, nil, "O",
      nil, nil, nil,
      nil, nil, "O"
    ]
    assert_equal 5, @computer_player.get_chosen_index(board)
  end

  def test_cp_block_opponents_win
    board = [
      "O", "X", "X",
      nil, "X", "O",
      nil, "O", "X"
    ]
    assert_equal 6, @computer_player.get_chosen_index(board)
  end

  def test_cp_gets_10_rank_for_win
    board = [
      "O", "O", "O",
      nil, nil, nil,
      nil, nil, nil
    ]

    assert_equal 10, @computer_player.get_ranking(board, true)
  end


  def test_cp_gets_negative_ten_rank_for_loss
    board = [
      "X", "X", "X",
      nil, nil, nil,
      nil, nil, nil
    ]
    assert_equal (-10), @computer_player.get_ranking(board, true)
  end

  def test_get_winner_returns_winner
    assert_equal "X", @computer_player.get_winner(["X", "X", "X", nil, nil, nil, nil, nil, nil])
    assert_equal "O", @computer_player.get_winner(["O", "O", "O", nil, nil, nil, nil, nil, nil])
    assert_nil @computer_player.get_winner(["X", "O", "X", nil, nil, nil, nil, nil, nil])
  end

  def test_board_is_full
    assert @computer_player.no_more_available_move?(["X", "O"])
    refute @computer_player.no_more_available_move?([nil, "X", "O"])
  end

  def test_ranks_and_index_gives_10
    board = [
      "X", "X", nil,
      nil, "O", "X",
      "X", "X", "O"
    ]
    available_spaces = [2, 3]
    ranks_and_index = @computer_player.ranks_and_index(available_spaces, board)
    assert_equal [[-9, 2],[-9, 3]], ranks_and_index
  end

  def test_fill_first_available_box
    board = [
     "X", "X", nil,
     nil, "O", "X",
     "X", "X", "O"
   ]

   next_board = board.dup
   next_board[2] = "X"

   result = @computer_player.fill_first_available_box(board, "X")
   assert_equal next_board, result
 end
end
