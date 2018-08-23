class Board
  attr_reader :board
  def initialize(board = nil)
    @board = board || [1,2,3,4,5,6,7,8,9]
  end

  def display_board(ui)
    ui.give(format_board(@board))
  end

  def format_board(board)
    "%s|%s|%s\n%s|%s|%s\n%s|%s|%s"%[*board]
  end

  def box_empty?(index)
    @board[index].class == Integer
  end

  def update(box_number, player)
    index = box_number.to_i - 1

    if box_empty?(index)
      @board[index] = player
      return true
    else
      return false
    end
  end

  def has_winner?
    #TODO dummy win checker
    @board[7] == "X"
  end

  def check
    #check if there are winning rows
    #check if there are winning columns
    #check if there are winning disgonals
    #if yes return the winner, if no, check if tied
    #else continue Play
    :PLAY
  end
end
