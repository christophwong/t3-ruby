class HumanPlayer
  def initialize(ui)
    @ui = ui
  end

  def get_chosen_index
    @ui.give("Please input a number from 1-9 to mark the correspondending box.")
    input = @ui.receive
    input.to_i - 1
  end
end
