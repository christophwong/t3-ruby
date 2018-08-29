module TestHelpers
def self.make_full_board_with_mixed_marks
    Array.new(9) { |i| i % 2 == 0 ? "X" : "O" }
  end
end
