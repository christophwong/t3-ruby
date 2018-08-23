class Game
  def initialize(ui, board)
    @ui = ui
    @board = board
  end

  def welcome
    @ui.give("Welcome to Tic-Tac-Toe, you are 'X', play to beat 'O'")
  end

  def game_over?
    @board.has_winner?
  end

  def next_move
    @board.display_board(@ui)
    user_input = @ui.receive
    @board.update(user_input)
  end

  def end
    @ui.give("Bye")
  end
end
