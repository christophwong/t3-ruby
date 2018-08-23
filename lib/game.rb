class Game
  def initialize(ui, board)
    @ui = ui
    @board = board
  end

  def start
    welcome
    @board.displayBoard(@ui)
    askForMove
  end

  def welcome
    @ui.give("Welcome to Tic-Tac-Toe, you are 'X', play to beat 'O'")
  end

  def askForMove
    @ui.give("Please type a number between 1-9 to mark your move on the grid with the same number on the board.")
    @ui.receive
  end

  def getMove(ui = @ui)
    input = @ui.receive
    @board.markMove(input)
  end
end
