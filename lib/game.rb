class Game
	def initialize(ui)
	  @ui = ui
	end

	def start
		@ui.give("Welcome to Tic-Tac-Toe, you are 'X', play to beat 'O'", @ui)
	end
end