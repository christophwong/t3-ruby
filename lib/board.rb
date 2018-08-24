class Board
  attr_reader :spaces
  attr_accessor :winner
  def initialize(spaces = nil)
    @spaces = spaces || [1,2,3,4,5,6,7,8,9]
    @winner = false
  end

  def display_board(ui)
    ui.give(format_board(@spaces))
  end

  def format_board(spaces)
    "%s|%s|%s\n%s|%s|%s\n%s|%s|%s"%[*spaces]
  end

  def empty_indices
    @spaces.reject{ |cell|
      cell == "X" or cell == "O"
    }.map{|i| i.to_i - 1}
  end

  def box_empty?(index)
    empty_indices.include?(index)
  end

  def update(index, player)
    if box_empty?(index)
      @spaces[index] = player
      check_for_winner
      return true
    else
      return false
    end
  end

  def check_for_winner
    @winner = check_rows || check_columns || check_diagonals
    return !!@winner
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
    diagonals = get_diagonals(@spaces)
    three_by_three_array_checker(diagonals)
  end

  def get_diagonals(spaces)
    rows = get_rows(spaces)
    top_left_to_bottom_right = []
    top_right_to_bottom_left = []

    rows.each_with_index do |row, index|
      top_left_to_bottom_right << row[index]
      top_right_to_bottom_left << row[2 - index]
    end

    return [top_left_to_bottom_right, top_right_to_bottom_left]
  end

  def check_columns
    columns = get_columns(@spaces)
    three_by_three_array_checker(columns)
  end

  def get_columns(spaces)
    get_rows(spaces).transpose
  end


  def check_rows
    rows = get_rows(@spaces)
    three_by_three_array_checker(rows)
  end

  def get_rows(spaces)
    rows = []
    copyboard = @spaces.dup
    3.times do |i|
      rows << copyboard.shift(3)
    end
    rows
  end

  def length
    @spaces.length
  end
end
