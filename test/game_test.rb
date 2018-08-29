require 'minitest/autorun'
require_relative '../lib/game.rb'

class TestGame < Minitest::Test
  def make_full_board_with_mixed_marks
    Array.new(9) { |i| i % 2 == 0 ? "X" : "O" }
  end

  def setup
    @game = Game.new
    @ui = Minitest::Mock.new
  end

  def test_game_initializes_with_empty_board
    game = Game.new
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


=begin

  NOTES: these are what game_runner calls
   [X]game.display_welcome
   [-]game.over?
   [X]game.display_board
   [ ]game.take_human_turn
   [ ]game.take_computer_turn
   [ ]game.end
=end


end
