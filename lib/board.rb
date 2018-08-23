class Board
  def initialize()
    @board = [1,2,3,4,5,6,7,8,9]
  end

  def displayBoard(ui)
    ui.give(formatBoard(@board))
  end

  def formatBoard(board)
    "%s|%s|%s\n%s|%s|%s\n%s|%s|%s"%[*board]
  end
end
