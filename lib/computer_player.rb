class ComputerPlayer
  def initialize
    @mark = "O"
    @human_mark = "X"
  end

  def get_chosen_index(board, computers_turn)
    available_spaces = board.get_available_spaces
    m = -> (idx){
        mark = computers_turn ? @mark : @human_mark
        new_board = board.dup
        new_board.state = board.state.dup
        new_board.update_with_index(idx, mark)
        minmax(new_board, !computers_turn)
      }

    if computers_turn
      available_spaces.max_by(&m)
    else
      available_spaces.min_by(&m)
    end
  end

  def minmax(board, computers_turn = true, depth = 0)
    rank = get_ranking(board, depth)
    mark = computers_turn ? @mark : @human_mark

    if rank
      return rank
    else
      available_spaces = board.get_available_spaces
      m = ->(idx){
        new_board = board.dup
        new_board.state = board.state.dup
        new_board.update_with_index(idx, mark)
        minmax(new_board, !computers_turn, (depth + 1))
      }

      available_spaces.map(&m).send(computers_turn ? :max : :min)
    end
  end

  def get_ranking(board, depth = 0)
    return (10 - depth) if board.O_wins?
    return (depth - 10) if board.X_wins?
    return 0 if board.no_available_moves?
  end
end
