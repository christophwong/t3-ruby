class Game
  attr_accessor :board, :current_player

  def initialize(human_player, computer_player)
    @board = Array.new(9)
    @human_player = human_player
    @computer_player = computer_player
  end

  def display_welcome(ui)
    ui.give("Welcome")
  end

  def display_board(ui)
    ui.give(format_board(board))
  end

  def format_board(board)
    numbered_board = board.map.with_index{|cell, i|
      if cell.nil?
        i + 1
      else
        cell
      end
    }
    "%s|%s|%s\n%s|%s|%s\n%s|%s|%s"%[*numbered_board]
  end

  def over?
    board_is_full = false
    board.each{|cell|
      board_is_full = board_is_full || cell
    }
    !!board_is_full
  end

  def take_human_turn
    chosen_index = @human_player.get_chosen_index
    @board[chosen_index] = "X"
    @current_player = "O"
  end

  def take_computer_turn
    chosen_index = @computer_player.get_chosen_index
    @board[chosen_index] = "O"
    @current_player = "X"
  end

end
