class ComputerPlayer
  def initialize(mark = "O")
    @mark = mark
  end

  def make_move(board)
    board.update(board.empty_indices.sample, @mark)
  end
end
