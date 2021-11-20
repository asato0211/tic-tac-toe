require 'minitest/autorun'
require_relative '../base_player/base_player'
require_relative '../minimax_player/minimax_player'
require_relative '../game/game'
require_relative '../const'

class MinimaxPlayerTest < Minitest::Test
  
  def test_select_position
    minimax = MinimaxPlayer.new

    # [行2,列1]に駒を置かないと負けてしまう状態 → 負けない為の一手[行2,列1]を打つことを担保
    game_state_1 = Game.new
    game_state_1.board = [
      [PIECE_X,PIECE_O,PIECE_X],
      [NONE,PIECE_O,NONE],
      [NONE,NONE,NONE]
    ]
    assert_equal [2,1], minimax.select_position(game_state_1)

    # [行2,列0]に駒を置けば勝ちになる状態 → 勝つ為の一手[行2,列0]を打つことを担保
    game_state_2 = Game.new
    game_state_2.board = [
      [PIECE_X,PIECE_O,PIECE_X],
      [NONE,PIECE_X,NONE],
      [NONE,PIECE_O,PIECE_O]
    ]
    assert_equal [2,0], minimax.select_position(game_state_2)

    # [行2,列2]に駒を置けば詰みになる状態 → 勝つ為の一手[行2,列2]を打つことを担保
    game_state_3 = Game.new
    game_state_3.board = [
      [NONE,NONE,NONE],
      [PIECE_O,PIECE_X,PIECE_X],
      [NONE,PIECE_O,NONE]
    ]
    assert_equal [2,2], minimax.select_position(game_state_3)

    # どこに置いても負けになる状態 → ゲームを長引かせる為の一手[行0,列2]を打つことを担保
    # ゲームツリーの深さに応じて評価されているかチェック
    game_state_4 = Game.new
    game_state_4.board = [
      [NONE,PIECE_O,NONE],
      [NONE,NONE,PIECE_O],
      [PIECE_X,PIECE_X,PIECE_O]
    ]
    assert_equal [0,2], minimax.select_position(game_state_4)    

    # 最後のターンで絶対に引き分けになる状態 → 空いている座標[行1,列0]に打つことを担保
    game_state_5 = Game.new
    game_state_5.board = [
      [PIECE_O,PIECE_X,PIECE_O],
      [NONE,PIECE_O,PIECE_X],
      [PIECE_X,PIECE_O,PIECE_X]
    ]
    assert_equal [1,0], minimax.select_position(game_state_5)
    
  end
end