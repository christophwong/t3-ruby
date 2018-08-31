class ComputerPlayer
  def initialize
    @mark = "O"
  end

  def get_chosen_index(board)
    ranks_and_i = ranks_and_index(board)
    select_index_from_rank_pair ranks_and_i.max

  end

  def ranks_and_index(board)
    ranks = []
    available_spaces = board.get_available_spaces
    computer_players_turn = true

    available_spaces.each do |i|
      next_board = board.dup
      next_board.state = board.state.dup
      next_board.update_with_index(i, @mark)
      rank = get_ranking(next_board, computer_players_turn)
      ranks << [rank, i]
    end

    ranks
  end

  def select_index_from_rank_pair(rank)
    rank[1]
  end

  def get_ranking(board, computer_players_turn, depth = 0)
  winner = board.winner
    if winner == "O"
      return (10 - depth)
    elsif winner == "X"
      return (-10 + depth)
    elsif board.no_available_moves?
      return (0 - depth)
    else
      depth += 1
      computer_players_turn = !computer_players_turn
      mark = computer_players_turn ? "O" : "X"
      #question: filling first box seems wrong. Shall we fill with minmax strategy? Yes! i think so
      # TODO: minmax strategy for next states
      next_board = board.new_board_with_first_available_box_filled(mark)
      return get_ranking(next_board, computer_players_turn, depth)
    end
  end
end
