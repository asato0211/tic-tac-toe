require_relative '../base_player/base_player'
require_relative '../game/game'

# can_place_pieceのテスト
# return true
def can_place_piece_test_return_ture(game, row, col)
  result = game.can_place_piece?(row, col)
  raise StandardError, 'can_place_piece testError' unless result
end

# return false
def can_place_piece_test_return_false(game, row, col)
  result = game.can_place_piece?(row, col)
  raise StandardError, 'can_place_piece testError' if result
end

# ボードの中身が全て埋まっている状態 --> falseが帰ってくることを担保
def can_place_piece_test_board_is_full(full_board_game)
  result = full_board_game.can_place_piece?(1, 0)
  raise StandardError, 'can_place_piece testError' if result
end

game = Game.new

# ボードの中身が全てNONEの状態 --> rowに0が入るとtrueが帰ってくることを担保
can_place_piece_test_return_ture(game, 0, 2)
# ボードの中身が全てNONEの状態 --> colに0が入るとtrueが帰ってくることを担保
can_place_piece_test_return_ture(game, 2, 0)

# ボードの中身が全てNONEの状態 --> rowに3が入るとfalseが帰ってくることを担保
can_place_piece_test_return_false(game, 3, 2)
# ボードの中身が全てNONEの状態 --> colに3が入るとfalseが帰ってくることを担保
can_place_piece_test_return_false(game, 2, 3)
# ボードの中身が全てNONEの状態 --> rowに-1が入るとfalseが帰ってくることを担保
can_place_piece_test_return_false(game, -1, 2)
# ボードの中身が全てNONEの状態 --> colに-1が入るとfalseが帰ってくることを担保
can_place_piece_test_return_false(game, 2, -1)

# ボードの中身が全て埋まっている状態 --> falseが帰ってくることを担保
full_board_game = Game.new
full_board_game.board = [
  [PIECE_O, PIECE_X, PIECE_X],
  [PIECE_X, PIECE_O, PIECE_O],
  [PIECE_X, PIECE_O, PIECE_X]
]
can_place_piece_test_board_is_full(full_board_game)
