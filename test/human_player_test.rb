require 'minitest/autorun'
require_relative '../lib/human_player.rb'

class TestHumanPlayer < Minitest::Test
  def setup
    @ui = Minitest::Mock.new
    @human = HumanPlayer.new(@ui)
  end

  def test_get_chosen_index_asks_users_input
    @ui.expect(:give, nil, [/Please.+1-9/])
    @ui.expect(:receive, "2")

    assert_equal 1, @human.get_chosen_index
    @ui.verify
  end
end
