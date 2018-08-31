require 'minitest/autorun'
require_relative '../lib/board'
require_relative '../lib/computer_player'
require_relative './test_helpers.rb'

class TestComputerPlayer < Minitest::Test
  def setup
    @computer_player = ComputerPlayer.new
    @full_board = TestHelpers.make_full_board_with_mixed_marks
    @board = Board.new
  end

  def test_cp_chosing_index_does_not_change_state
    original_state = @board.state.dup
    @computer_player.get_chosen_index @board

    assert_equal  original_state, @board.state
  end

  def test_cp_chose_only_available_spot
    board = @full_board.dup
    board[3] = nil
    @board.state = board
    assert_equal 3, @computer_player.get_chosen_index(@board)
  end

  def test_cp_chose_winning_move
    board = [
      nil, nil, "O",
      nil, nil, nil,
      nil, nil, "O"
    ]
    @board.state = board
    assert_equal 5, @computer_player.get_chosen_index(@board)
  end

  def test_cp_block_opponents_win
    board = [
      "O", "X", "X",
      nil, "X", "O",
      nil, "O", "X"
    ]
    @board.state = board
    assert_equal 6, @computer_player.get_chosen_index(@board)
  end

  def test_cp_gets_10_rank_for_win
    board = [
      "O", "O", "O",
      nil, nil, nil,
      nil, nil, nil
    ]
    @board.state = board
    assert_equal 10, @computer_player.get_ranking(@board, true)
  end


  def test_cp_gets_negative_ten_rank_for_loss
    board = [
      "X", "X", "X",
      nil, nil, nil,
      nil, nil, nil
    ]
    @board.state = board
    assert_equal (-10), @computer_player.get_ranking(@board, true)
  end



  def test_ranks_and_index_gives_10
    board = [
      "X", "X", nil,
      nil, "O", "X",
      "X", "X", "O"
    ]
    @board.state = board
    ranks_and_index = @computer_player.ranks_and_index(@board)
    assert_equal [[-9, 2],[-9, 3]], ranks_and_index
  end
end
