require "minitest/autorun"
require_relative "../base_player/base_player.rb"
require_relative "../game/game.rb"

# プライベートメソッドのテスト
class BasePlayerTest < Minitest::Test

  # ボードの中身が全てNONEの状態 --> rowまたはcolに0が入るとtrueが帰ってくることを担保
  def test_return_true_can_place_piece?
    row_and_col = [[0,2],[2,0]]
    row_and_col.each do |row,col|
      game = Game.new
      base_player = BasePlayer.new
      assert_equal true,base_player.send(:can_place_piece?,game.board,row,col)
    end
  end

  # ボードの中身が全てNONEの状態 --> rowまたはcolに3か-1が入るとfalseが帰ってくることを担保
  def test_return_false_can_place_piece?
    row_and_col = [[3,2],[2,3],[-1,2],[2,-1]]
    row_and_col.each do |row,col|
      game = Game.new
      base_player = BasePlayer.new
      assert_equal false ,base_player.send(:can_place_piece?,game.board,row,col)
    end
  end

  # ボードの中身がOで埋まってるの状態 --> falseが帰ってくることを担保 
  def test_board_is_full_can_place_piece?
    board = Array.new(3) { Array.new(3,PIECE_O) }
    base_player = BasePlayer.new
    assert_equal false ,base_player.send(:can_place_piece?,board,1,0)
  end
  
end
