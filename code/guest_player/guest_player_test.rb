require "minitest/autorun"
require "stringio"
require_relative "../base_player/base_player.rb"
require_relative "../guest_player/guest_player.rb"
require_relative "../game/game.rb"

class GuestPlayerTest < Minitest::Test
  
  # 標準入力で指定した(row=0,col=0)がボード用の座標指定[1,1]になることを担保
  def test_select_position_row_and_col_is_0
    guest = GuestPlayer.new
    game = Game.new
    guest.stub :select_position, [0,0] do
      assert_equal [0,0],guest.select_position(game.board)
    end
  end

  # 標準入力で指定した(row=2,col=2)がボード用の座標指定[1,1]になることを担保
  def test_select_position_row_and_col_is_2
    guest = GuestPlayer.new
    game = Game.new
    guest.stub :select_position, [2,2] do
      assert_equal [2,2],guest.select_position(game.board)
    end
  end  
end
