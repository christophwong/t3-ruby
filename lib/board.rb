class Board
  attr_accessor :state
  def initialize
    @state = Array.new(9)
  end

  def empty?
    get_available_spaces.length == 9
  end

  def format_board
    numbered_board = @state.map.with_index{|cell, i|
      if cell.nil?
        i + 1
      else
        cell
      end
    }
    "%s|%s|%s\n%s|%s|%s\n%s|%s|%s"%[*numbered_board]
  end


  def get_available_spaces
    available_spaces = []
    @state.each_with_index do |cell, i|
      if cell.nil?
        available_spaces << i
      end
    end
    available_spaces
  end

  def update_with_index(index, mark)
    @state[index] = mark
  end

  def new_board_with_first_available_box_filled(mark)
    i = get_available_spaces.first
    new_board = Board.new
    new_board.state = @state.dup
    new_board.update_with_index(i, mark)

    return new_board
  end

  def get_cell(index)
    @state[index]
  end

  def in_end_state?
     no_available_moves? || X_wins? || O_wins?
  end

  def no_available_moves?
    get_available_spaces.length == 0
  end

  def X_wins?
    winner == "X"
  end

  def O_wins?
    winner == "O"
  end

  def winner
    check_combos(get_all_combos(@state))
  end

  def check_combos(combos)
    return "X" if check_win_for(combos, "X")
    return "O" if check_win_for(combos, "O")
  end

  def check_win_for(combos, mark)
    combos.include?(Array.new(3, mark))
  end

  def get_all_combos(board)
    rows = get_row(board)
    columns = get_col(rows)
    diagonals = get_diag(rows)
    [*rows, *columns, *diagonals]
  end

  def get_diag(rows)
    top_left_to_bottom_right = []
    top_right_to_bottom_left = []

    rows.each_with_index do |row, index|
      top_left_to_bottom_right << row[index]
      top_right_to_bottom_left << row[2 - index]
    end

    return [top_left_to_bottom_right, top_right_to_bottom_left]
  end

  def get_col(rows)
    rows.transpose
  end

  def get_row(board)
    rows = []
    board = board.dup
    3.times do |i|
      rows << board.shift(3)
    end
    rows
  end

end
