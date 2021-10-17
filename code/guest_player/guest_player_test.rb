require "minitest/autorun"
require "stringio"
require_relative "../base_player/base_player.rb"
require_relative "../guest_player/guest_player.rb"
require_relative "../game/game.rb"

class GuestPlayerTest < Minitest::Test
  
  # 標準入力で指定した(row=1,col=1)がボード用の座標指定[1,1]になることを担保
  def test_select_position
    guest = GuestPlayer.new
    game = Game.new
    assert_equal [1,1],guest.select_position(game.board)
  end
end
