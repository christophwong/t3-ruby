class Game
  attr_accessor :board

  def initialize
    @board = Array.new(9)
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
    full = false
    board.each{|cell|
      full = full || cell
    }
    full
  end

  def self.run(ui)
    ui.give("Welcome")
  end
end
