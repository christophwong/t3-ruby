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
    check
  end

  def check
    check_rows
  end

  def check_rows
    rows = []
    copyboard = @board.dup #i wanna write test for this
    3.times do |i|
      rows << copyboard.shift(3)
    end
    rows.each do |row|
      return "X" if row == Array.new(3, "X")
      return "O" if row == Array.new(3, "O")
    end
    false
  end

  def length
    @board.length
  end
end
