require_relative './board.rb'

class Game
  attr_accessor :current_player
  attr_reader :board

  def initialize(human_player, computer_player, ui = nil)
    @board = Board.new
    @human_player = human_player
    @computer_player = computer_player
    @ui = ui || UI.new
  end

  def set_board(state)
    @board.state = state
  end

  def display_welcome
    @ui.give("Welcome")
  end

  def display_board
    @ui.give(format_board(board))
  end

  def format_board(board)
    numbered_board = board.state.map.with_index{|cell, i|
      if cell.nil?
        i + 1
      else
        cell
      end
    }
    "%s|%s|%s\n%s|%s|%s\n%s|%s|%s"%[*numbered_board]
  end

  def over?
    board.in_end_state?
  end

  def take_human_turn
    chosen_index = @human_player.get_chosen_index
    @board.update_with_index(chosen_index, "X")
    @current_player = "O"
  end

  def take_computer_turn
    chosen_index = @computer_player.get_chosen_index(@board.state)
    @board.update_with_index(chosen_index, "O")
    @current_player = "X"
  end

  def end
    @ui.give("Bye bye")
  end

end
