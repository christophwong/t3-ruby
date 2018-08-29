require 'minitest/autorun'
require_relative '../lib/game.rb'
require_relative './test_helpers.rb'

class TestGame < Minitest::Test
  def make_full_board_with_mixed_marks
    TestHelpers.make_full_board_with_mixed_marks
  end

  def setup
    @player = Minitest::Mock.new
    @computer_player = Minitest::Mock.new
    @game = Game.new(@player, @computer_player)
    @ui = Minitest::Mock.new
  end

  def test_game_initializes_with_empty_board
    game = Game.new(@player, @computer_player)
    array_of_nine_empty_cells = Array.new(9)
    assert_equal array_of_nine_empty_cells, game.board
  end

  def test_game_runs_displays_welcome
    @ui.expect(:give, nil, [/Welcome/])
    @game.display_welcome(@ui)
    @ui.verify
  end

  def test_game_isnt_over_with_empty_board
    @game.board = Array.new(9)
    refute @game.over?
  end

  def test_game_is_over_when_board_is_filled
    @game.board = make_full_board_with_mixed_marks
    assert @game.over?
  end

  def test_game_displays_numbered_board
    @game.board = Array.new(9)
    board_pattern = /(\d[\|\n]?){9}/
    @ui.expect(:give, nil, [board_pattern])
    @game.display_board(@ui)
    @ui.verify
  end

  def test_human_turn_marks_human_player_move_on_board
    chosen_index = 0
    human_player = Minitest::Mock.new
    human_player.expect(:get_chosen_index, chosen_index)

    game = Game.new(human_player, @computer_player)
    game.board = Array.new(9)
    game.current_player = "X"

    game.take_human_turn

    human_player.verify

    assert_equal "X", game.board[chosen_index]
    assert_equal "O", game.current_player
  end

  def test_computer_turn_marks_computer_player_move_on_board
    chosen_index = 0
    computer_player = Minitest::Mock.new
    computer_player.expect(:get_chosen_index, chosen_index)


    game = Game.new(@player, computer_player)
    game.board = Array.new(9)
    game.current_player = "O"

    game.take_computer_turn

    computer_player.verify

    assert_equal "O", game.board[chosen_index]
    assert_equal "X", game.current_player
  end

=begin

  NOTES: these are what game_runner calls
   [X]game.display_welcome
   [X]game.over?
   [X]game.display_board
   [-]game.take_human_turn {maybe add validation}
   [-]game.take_computer_turn
   [ ] game.over?
   [ ]game.end
=end


end