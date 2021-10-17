require "minitest/autorun"
require_relative "../base_player/base_player.rb"
require_relative "../cpu_player/cpu_player.rb"
require_relative "../game/game.rb"

class CpuPlayerTest < Minitest::Test
  
  # boardの空いている座標が2列目の右端だった場合、座標[1,2]を返すことを担保
  def test_select_position
    cpu = CpuPlayer.new
    board = [
      [PIECE_X,PIECE_O,PIECE_O],
      [PIECE_O,PIECE_X,NONE],
      [PIECE_X,PIECE_O,PIECE_O]
    ]
    assert_equal [1,2],cpu.select_position(board)
  end
end