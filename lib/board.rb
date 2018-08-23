class Board
  def initialize(board = nil)
    @board = board || [1,2,3,4,5,6,7,8,9]
  end

  def display_board(ui)
    ui.give(format_board(@board))
  end

  def format_board(board)
    "%s|%s|%s\n%s|%s|%s\n%s|%s|%s"%[*board]
  end

  def has_winner?
    #TODO dummy win checker
    @board[7] == "O"
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
