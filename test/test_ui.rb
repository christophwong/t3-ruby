require 'minitest/autorun'
require_relative '../lib/ui.rb'

class TestUI < Minitest::Test

  def setup
  	@ui = UI.new
  	@input = StringIO.new
  	@output = StringIO.new
  end

  def test_ui_returns_user_input
  	test_string = "Hello World."
    @input.puts test_string
    @input.rewind
    assert_equal test_string, @ui.receive(@input)
  end

  def test_ui_outputs_message_to_user
    test_string = "Hello World."

    @ui.give(test_string, @output)
    assert_match test_string, @output.string
  end
end
