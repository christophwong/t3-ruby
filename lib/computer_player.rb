class ComputerPlayer
  def initialize
    @mark = "O"
    @human_mark = "X"
  end

  def get_chosen_index(board, computer_players_turn)
    ranks_and_i = ranks_and_index(board, computer_players_turn)
    min_or_max = computer_players_turn ? ranks_and_i.max : ranks_and_i.min
    select_index_from_rank_pair min_or_max
  end

  def ranks_and_index(board, computer_players_turn)
    ranks = []
    available_spaces = board.get_available_spaces
    available_spaces.each do |i|
      next_board = board.dup
      next_board.state = board.state.dup
      mark = computer_players_turn ? @mark : @human_mark

      next_board.update_with_index(i, mark)
      rank = get_ranking(next_board, !computer_players_turn)
      ranks << [rank, i]
    end

    ranks
  end

  def select_index_from_rank_pair(rank)
    rank[1]
  end

  def get_ranking(board, computer_players_turn, depth = 0)
    if depth > 11
      throw Error
    end
  winner = board.winner
    if winner == "O"
      return (10 - depth)
    elsif winner == "X"
      return (-10 + depth)
    elsif board.no_available_moves?
      return (0 - depth)
    else
      depth += 1
      mark = computer_players_turn ? @mark : @human_mark
      next_board = board.dup
      chosen_index = get_chosen_index(next_board, computer_players_turn)
      next_board.update_with_index(chosen_index, mark)
      return get_ranking(next_board, !computer_players_turn, depth)
    end
  end
end
