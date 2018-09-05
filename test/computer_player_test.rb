require 'minitest/autorun'
require_relative '../lib/board'
require_relative '../lib/computer_player'
require_relative './test_helpers.rb'

class TestComputerPlayer < Minitest::Test
  def setup
    @board = Board.new
    @computer_player = ComputerPlayer.new
    @computers_turn = true
  end

  def test_computer_player_gets_ranking_nil_for_unfinished_boards
    ranking = @computer_player.get_ranking(@board)
    assert_nil ranking
  end

  def test_get_ranking_for_win
    @board.state = [
      "O", "O", "O",
      "X", nil, "X",
      "X", "O", "X"
    ]
    rank = @computer_player.get_ranking(@board)
    assert_equal 10, rank
  end

  def test_get_ranking_for_loss
    @board.state = [
      "X", "O", "O",
      "X", nil, "X",
      "X", "O", "X"
    ]
    rank = @computer_player.get_ranking(@board)
    assert_equal (-10), rank
  end

  def test_get_ranking_for_tied_game
    @board.state = [
      "O", "X", "O",
      "X", "O", "X",
      "X", "O", "X"
    ]
    rank = @computer_player.get_ranking(@board)
    assert_equal 0, rank
  end

  def test_minmax_for_win
    @board.state = [
      "O", "O", "O",
      "X", nil, "X",
      "X", "O", "X"
    ]
    rank = @computer_player.minmax(@board)
    assert_equal 10, rank
  end

  def test_minmax_for_loss
    @board.state = [
      "X", "O", "O",
      "X", nil, "X",
      "X", "O", "X"
    ]
    rank = @computer_player.minmax(@board)
    assert_equal (-10), rank
  end

  def test_minmax_for_tied_game
    @board.state = [
      "O", "X", "O",
      "X", "O", "X",
      "X", "O", "X"
    ]
    rank = @computer_player.minmax(@board)
    assert_equal 0, rank
  end

  def test_minmax_for_win_one_step_away
    @board.state = [
      "O", nil, "O",
      "X", nil, "X",
      "X", "O", "X"
    ]

    rank = @computer_player.minmax(@board, @computers_turn)
    assert_equal 9, rank
  end


  def test_minmax_for_loss_one_step_away
    @board.state = [
      "O", nil, "O",
      "X", nil, "X",
      "X", "O", "X"
    ]

    rank = @computer_player.minmax(@board, !@computers_turn)
    assert_equal (-9), rank
  end

  def test_get_chosen_index_choose_winning_move
    @board.state = [
      "O", "O", "X",
      nil, nil, nil,
      nil, "O", "X",
    ]
    assert_equal 4, @computer_player.get_chosen_index(@board, @computers_turn)
    assert_equal 5, @computer_player.get_chosen_index(@board, !@computers_turn)
  end
end
