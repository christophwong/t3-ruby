require 'minitest/autorun'
require_relative '../lib/start.rb'

class TestStart < Minitest::Test
  def test_start_script_calls_start_game
    @game = Minitest::Mock.new
    @game.expect(:start, nil)

    Start.run(@game)
    @game.verify
  end
end
