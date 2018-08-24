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
    check_rows || check_columns || check_diagonals
  end

  def three_by_three_array_checker(array_of_3)
    if array_of_3[0].length != 3
      raise ArgumentError("Argument must be array of arrays of size 3")
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

  def check_diagonals
    diagonals = get_diagonals(@board)
    three_by_three_array_checker(diagonals)
  end

  def get_diagonals(board)
    rows = get_rows(board)
    top_left_to_bottom_right = []
    top_right_to_bottom_left = []

    rows.each_with_index do |row, index|
      top_left_to_bottom_right << row[index]
      top_right_to_bottom_left << row[2 - index]
    end

    return [top_left_to_bottom_right, top_right_to_bottom_left]
  end

  def check_columns
    columns = get_columns(@board)
    three_by_three_array_checker(columns)
  end

  def get_columns(board)
    get_rows(board).transpose
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

  def length
    @board.length
  end
end
