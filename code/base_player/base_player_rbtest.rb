require_relative "../base_player/base_player.rb"
require_relative "../game/game.rb"

# return true
def can_place_piece_test_return_ture(game,player,row,col)
  result = player.send(:can_place_piece?,game.board,row,col)
  if !result
    raise StandardError.new("can_place_piece testError")
  end
end

# return false
def can_place_piece_test_return_false(game,player,row,col)
  result = player.send(:can_place_piece?,game.board,row,col)
  if result
    raise StandardError.new("can_place_piece testError")
  end
end

# ボードの中身がOで埋まってるの状態 --> falseが帰ってくることを担保 
def can_place_piece_test_board_is_full(board,player)
  result = player.send(:can_place_piece?,board,1,0)
  if result
    raise StandardError.new("can_place_piece testError")
  end
end

game = Game.new
player = BasePlayer.new

# ボードの中身が全てNONEの状態 --> rowに0が入るとtrueが帰ってくることを担保 
can_place_piece_test_return_ture(game,player,0,2)
# ボードの中身が全てNONEの状態 --> colに0が入るとtrueが帰ってくることを担保 
can_place_piece_test_return_ture(game,player,2,0)

# ボードの中身が全てNONEの状態 --> rowに3が入るとfalseが帰ってくることを担保 
can_place_piece_test_return_false(game,player,3,2)
# ボードの中身が全てNONEの状態 --> colに3が入るとfalseが帰ってくることを担保 
can_place_piece_test_return_false(game,player,2,3)
# ボードの中身が全てNONEの状態 --> rowに-1が入るとfalseが帰ってくることを担保 
can_place_piece_test_return_false(game,player,-1,2)
# ボードの中身が全てNONEの状態 --> colに-1が入るとfalseが帰ってくることを担保 
can_place_piece_test_return_false(game,player,2,-1)

# ボードの中身がOで埋まってるの状態 --> falseが帰ってくることを担保 
board = Array.new(3) { Array.new(3,PIECE_O) }
can_place_piece_test_board_is_full(board,player)