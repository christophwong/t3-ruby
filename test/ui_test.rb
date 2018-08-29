require 'minitest/autorun'
require_relative '../lib/ui.rb'

class TestUI < Minitest::Test
  def test_ui_can_give_message_with_new_line
    io = StringIO.new
    ui = UI.new
    message = "test message\n"
    ui.give(message, io)
    result = io.string

    assert_equal message, result
  end

  def test_ui_can_receive_user_input
    ui = UI.new
    test_string = "Test String"
    io = StringIO.new(test_string)
    result = ui.receive(io)

    assert_equal test_string, result
  end
end
