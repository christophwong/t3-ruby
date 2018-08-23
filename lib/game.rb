class Game
  def initialize(ui, board)
    @ui = ui
    @board = board
  end

  def start
    welcome
    @board.display_board(@ui)
    ask_for_move
  end

  def welcome
    @ui.give("Welcome to Tic-Tac-Toe, you are 'X', play to beat 'O'")
  end

  def ask_for_move
    @ui.give("Please type a number between 1-9 to mark your move on the grid with the same number on the board.")
    @ui.receive
  end

  def get_move(ui = @ui)
    input = @ui.receive
    @board.mark_move(input)
  end
end
