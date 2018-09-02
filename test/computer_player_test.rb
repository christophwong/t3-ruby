require 'minitest/autorun'
require_relative '../lib/board'
require_relative '../lib/computer_player'
require_relative './test_helpers.rb'

class TestComputerPlayer < Minitest::Test
  def setup
    @computer_player = ComputerPlayer.new
    @full_board = TestHelpers.make_full_board_with_mixed_marks
    @board = Board.new
    @computers_turn = true
  end

  def test_cp_chosing_index_does_not_change_state
    @board.state = [
      nil, "X", nil,
      "O", nil, nil,
      "X", nil, "O",
    ]
    original_state = @board.state.dup
    @computer_player.get_chosen_index(@board, @computers_turn)

    assert_equal  original_state, @board.state
  end

  def test_cp_chose_only_available_spot
    board = @full_board.dup
    board[3] = nil
    @board.state = board
    assert_equal 3, @computer_player.get_chosen_index(@board, @computers_turn)
  end

  def test_cp_chose_winning_move
    board = [
      nil, nil, "O",
      nil, nil, nil,
      nil, nil, "O"
    ]
    @board.state = board
    assert_equal 5, @computer_player.get_chosen_index(@board, @computers_turn)
  end

  def test_cp_chose_winning_move_for_opponent
    board = [
      nil, nil, "X",
      nil, nil, nil,
      nil, nil, "X"
    ]
    @board.state = board
    assert_equal 5, @computer_player.get_chosen_index(@board, !@computers_turn)
  end

  def test_cp_block_opponents_win
    board = [
      "O", "X", "X",
      nil, "X", "O",
      nil, "O", "X"
    ]
    @board.state = board
    assert_equal 6, @computer_player.get_chosen_index(@board, @computers_turn)
  end

  def test_ranks_and_index_returns_negative_eight_for_check_mate_situation
    board = [
      "X", "X", nil,
      nil, "O", "X",
      "X", "X", "O"
    ]
    @board.state = board
    ranks_and_index = @computer_player.ranks_and_index(@board, @computers_turn)
    assert_equal [[-9, 2],[-9, 3]], ranks_and_index
  end

  def test_cp_gets_10_rank_for_win
    board = [
      "O", "O", "O",
      nil, nil, nil,
      nil, nil, nil
    ]
    @board.state = board
    assert_equal 10, @computer_player.get_ranking(@board, @computers_turn)
  end

  def test_cp_gets_negative_ten_rank_for_loss
    board = [
      "X", "X", "X",
      nil, nil, nil,
      nil, nil, nil
    ]
    @board.state = board
    assert_equal (-10), @computer_player.get_ranking(@board, @computers_turn)
  end

  def test_cp_gets_0_for_ties
    board = [
      "X", "O", "X",
      "O", "O", "X",
      "X", "X", "O"
    ]
    @board.state = board

    assert_equal (0), @computer_player.get_ranking(@board, @computers_turn)
  end

  def test_cp_gets_9_for_win_a_step_away
    board = [
      "O", nil, "O",
      nil, nil, nil,
      nil, nil, nil
    ]
    @board.state = board
    assert_equal 9, @computer_player.get_ranking(@board, @computers_turn)
  end

  def test_cp_gets_min_9_for_loss_a_step_away
    board = [
      "O", "X", "O",
      nil, "X", nil,
      nil, nil, nil
    ]
    @board.state = board
    assert_equal (-9), @computer_player.get_ranking(@board, !@computers_turn)
  end

  def test_cp_gets_min_1_for_tie_a_step_away
    board = [
      "X", "O", "X",
      "O", "O", "X",
      "X", "X", nil
    ]
    @board.state = board
    assert_equal (-1), @computer_player.get_ranking(@board, @computers_turn)
  end

  def test_cp_does_not_belittle_opponent
    board = [
      nil, nil, nil,
      nil, "X", "X",
      nil, "O", nil,
    ]
    @board.state = board
    assert_equal 3, @computer_player.get_chosen_index(@board, true)
    assert_equal -9, @computer_player.get_ranking(@board, !@computers_turn)
  end
end
