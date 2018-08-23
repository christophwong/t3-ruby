require 'minitest/autorun'
require_relative '../lib/ui.rb'

class TestUI < Minitest::Test

  def setup
  	@ui = UI.new
  	@input = StringIO.new
  	@output = StringIO.new
  end

  def test_ui_returns_user_input
  	testString = "Hello World."
    @input.puts testString
    @input.rewind
    assert_equal testString, @ui.receive(@input)
  end

  def test_ui_outputs_message_to_user
    testString = "Hello World."

    @ui.give(testString, @output)
    assert_match testString, @output.string
  end
end
