class ComputerPlayer
  def get_chosen_index(board)
    available_spaces = []
    board.each_with_index {|cell, i|
      if cell.nil?
        available_spaces << i
      end
    }
    available_spaces.first
  end
end
