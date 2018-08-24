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
    check_rows || check_columns
  end

  def three_by_three_array_checker(array_of_3)
    if array_of_3.length != 3 || array_of_3[0].length != 3
      raise ArgumentError("Argument must be 3 X 3 array")
    end
    array_of_3.each do |cell|
      ["X", "O"].each do |mark|
        if cell == Array.new(3, mark)
          return mark
        end
      end
    end
   return false
  end

  def check_columns
    columns = get_columns(@board)
    three_by_three_array_checker(columns)
  end

  def check_rows
    rows = get_rows(@board)
    three_by_three_array_checker(rows)
  end

  def get_rows(board)
    rows = []
    copyboard = @board.dup
    3.times do |i|
      rows << copyboard.shift(3)
    end
    rows
  end

  def get_columns(board)
    get_rows(board).transpose
  end

  def length
    @board.length
  end
end
