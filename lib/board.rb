class Board
  def initialize()
    @board = [1,2,3,4,5,6,7,8,9]
  end

  def display_board(ui)
    ui.give(format_board(@board))
  end

  def format_board(board)
    "%s|%s|%s\n%s|%s|%s\n%s|%s|%s"%[*board]
  end
end
