require 'minitest/autorun'
require_relative '../lib/ui.rb'

class TestUI < Minitest::Test

  def setup
  	@ui = UI.new
  	@input = StringIO.new("AA")
  	@output = StringIO.new
  end

  def test_ui_returns_user_input
  	testString = "Hello World."
    @input.puts testString
    @input.rewind
    assert_equal "Hello World.", @ui.receive(@input)
  end
end