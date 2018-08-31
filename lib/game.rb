require_relative './board.rb'
require_relative './ui.rb'
require_relative './human_player.rb'
require_relative './computer_player.rb'

class Game
  attr_accessor :current_player
  attr_reader :board

  def initialize(human_player = nil, computer_player = nil, ui = nil, board = nil)
    @board = board || Board.new
    @ui = ui || UI.new
    @human_player = human_player || HumanPlayer.new(@ui)
    @computer_player = computer_player || ComputerPlayer.new
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
    chosen_index = @computer_player.get_chosen_index(@board)

    @board.update_with_index(chosen_index, "O")
    @current_player = "X"
  end

  def end
    @ui.give("Winner is #{board.winner}")
    display_board
  end

end
