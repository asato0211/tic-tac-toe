require 'minitest/autorun'
require_relative '../base_player/base_player'
require_relative '../random_player/random_player'
require_relative '../game/game'

class RandomPlayerTest < Minitest::Test
  def test_select_position
    # boardの空いている座標が2列目の右端のみの場合、座標[1,2]を返すことを担保
    random = RandomPlayer.new
    board = [
      [PIECE_X, PIECE_O, PIECE_O],
      [PIECE_O, PIECE_X, NONE],
      [PIECE_X, PIECE_O, PIECE_O]
    ]
    assert_equal [1, 2], random.select_position(board)

    # スタブ[0,0]
    game = Game.new
    random.stub :select_position, [0, 0] do
      assert_equal [0, 0], random.select_position(game.board)
    end

    # スタブ[2,2]
    random.stub :select_position, [2, 2] do
      assert_equal [2, 2], random.select_position(game.board)
    end
  end
end
