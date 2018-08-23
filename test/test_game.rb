require 'minitest/autorun'
require_relative '../lib/game.rb'

class TestGame < Minitest::Test
  def setup
  	@ui = Minitest::Mock.new
    @board = Minitest::Mock.new
    @game = Game.new(@ui, @board)

  end

  def test_start_game_welcomes_player_and_display_board
    ask_for_move_pattern = /^Please{1}.+1-9{1}.+mark{1}.+move{1}.+\.$/

    @ui.expect(:give, nil, [/Welcome/])
    @board.expect(:display_board, nil, [@ui])
    @ui.expect(:give, nil, [ask_for_move_pattern])
    @ui.expect(:receive, nil)
    @game.start
    @ui.verify
    @board.verify
  end

  def test_game_sends_user_input_to_board
    move = "1"
    @ui.expect(:receive, move)
    @board.expect(:mark_move, nil, [move])
    @game.get_move(@ui)
    @ui.verify
    @board.verify
  end
end
