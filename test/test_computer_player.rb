require 'minitest/autorun'
require 'computer_player'

class TestComputerPlayer < Minitest::Test
  def test_com_player_makes_lucky_winning_move
    spaces = %w(X O O
                X O X
                7 8 X)
    board = Board.new(spaces)
    assert_equal false, board.winner
    computer_player = ComputerPlayer.new("O")
    computer_player.make_move(board)
    assert_equal "O", board.winner
  end
end
