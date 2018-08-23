class Game
  def initialize(ui, board)
    @ui = ui
    @board = board
  end

  def start
    welcome
    @board.displayBoard(@ui)
  end

  def welcome
    @ui.give("Welcome to Tic-Tac-Toe, you are 'X', play to beat 'O'", @ui)
  end
end
