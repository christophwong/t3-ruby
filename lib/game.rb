class Game
  def initialize(ui, board)
    @ui = ui
    @board = board
    @player = "X"
  end

  def welcome
    @ui.give("Welcome to Tic-Tac-Toe, you are 'X', play to beat 'O'")
  end

  def game_over?
    @board.check_for_winner
  end

  def next_move
    @board.display_board(@ui)
    user_input = @ui.receive
    index = user_input.to_i - 1
    update_player if @board.update(index, @player)
  end

  def end
    @ui.give("Game is Over, Winner is #{@board.winner}")
    @board.display_board(@ui)
    @ui.give("Bye")
  end

  def is_current_player_X?
    "X" == @player
  end

  def update_player
    @player = is_current_player_X? ? "O" : "X"
  end
end
