class ComputerPlayer
  def initialize
    @mark = "O"
  end

  def get_chosen_index(board)
    available_spaces = get_available_spaces(board)

    if available_spaces.one?
      return available_spaces.first
    end
    # and return their end state ranking (10, 0, -10)
    # if it's computer's turn, we want the index with ranking 10
    # because that means computer is winning, yay AI overlords
    # but 0 means no win or losses...
    #

    ranks_and_i = ranks_and_index(available_spaces, board)
    select_index_from_rank_pair ranks_and_i.max

  end

  def ranks_and_index(available_spaces, board)
    ranks = []
    computer_players_turn = true
    available_spaces.each do |i|
      next_board = board.dup
      next_board[i] = @mark
      rank = get_ranking(next_board, computer_players_turn)
      # puts "ranks is : #{rank} and i #{i}"
      ranks << [rank, i]
    end

    ranks
  end

  def select_index_from_rank_pair(rank)
    rank[1]
  end

  def get_ranking(board, computer_players_turn, depth = 0)
  winner = get_winner(board)
    if winner == "O"
      return (10 - depth)
    elsif winner == "X"
      return (-10 + depth)
    elsif no_more_available_move?(board)
      return (0 - depth)
    else
      depth += 1
      computer_players_turn = !computer_players_turn
      mark = computer_players_turn ? "O" : "X"
      #question: filling first box seems wrong. Shall we fill with minmax strategy? Yes! i think so
      next_board = fill_first_available_box(board, mark)

      return get_ranking(next_board, computer_players_turn, depth)
    end
  end

  def fill_first_available_box(board, mark)
    i = get_available_spaces(board).first
    new_board = board.dup
    new_board[i] = mark
    new_board
  end

  def no_more_available_move?(board)
    !board.include?(nil)
  end

  def get_available_spaces(board)
    available_spaces = []
    board.each_with_index do |cell, i|
      if cell.nil?
        available_spaces << i
      end
    end
    available_spaces
  end

  def get_winner(board)
    check_combos(get_all_combos(board))
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
