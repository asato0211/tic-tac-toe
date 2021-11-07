require 'minitest/autorun'
require_relative '../game/game'
require_relative '../base_player/base_player'
require_relative '../guest_player/guest_player'
require_relative '../random_player/random_player'

class GameTest < Minitest::Test
  def test_get_piece
    # ゲストの駒 => " o " になる事を担保
    game = Game.new
    guest = GuestPlayer.new
    assert_equal PIECE_O, game.get_piece(guest.class)

    # Rundomの駒 => " x " になる事を担保
    random = RandomPlayer.new
    assert_equal PIECE_X, game.get_piece(random.class)
  end

  def test_can_place_piece?
    game = Game.new

    # ボードの中身が全てNONEの状態 --> rowに0が入るとtrueが帰ってくることを担保
    assert_equal true, game.can_place_piece?(0, 2)

    # ボードの中身が全てNONEの状態 --> colに0が入るとtrueが帰ってくることを担保
    assert_equal true, game.can_place_piece?(2, 0)

    # ボードの中身が全てNONEの状態 --> rowに3が入るとfalseが帰ってくることを担保
    assert_equal false, game.can_place_piece?(3, 2)

    # ボードの中身が全てNONEの状態 --> colに3が入るとfalseが帰ってくることを担保
    assert_equal false, game.can_place_piece?(2, 3)

    # ボードの中身が全てNONEの状態 --> rowに-1が入るとfalseが帰ってくることを担保
    assert_equal false, game.can_place_piece?(-1, 2)

    # ボードの中身が全てNONEの状態 --> colに-1が入るとfalseが帰ってくることを担保
    assert_equal false, game.can_place_piece?(2, -1)

    # ボードの中身が全て埋まっている状態 --> falseが帰ってくることを担保
    full_board_game = Game.new
    full_board_game.board = [
      [PIECE_O, PIECE_X, PIECE_X],
      [PIECE_X, PIECE_O, PIECE_O],
      [PIECE_X, PIECE_O, PIECE_X]
    ]
    assert_equal false, full_board_game.can_place_piece?(1, 0)
  end

  def test_win?
    # " o " で横が揃っている場合、ゲストの勝利になる事を担保
    side = Game.new
    side.board = [
      [PIECE_O, PIECE_O, PIECE_O],
      [NONE, PIECE_X, PIECE_O],
      [PIECE_X, NONE, PIECE_X]
    ]
    assert_equal true, side.win?(PIECE_O)

    # " o " で縦が揃っている場合、ゲストの勝利になる事を担保
    vertically = Game.new
    vertically.board = [
      [PIECE_O, NONE, PIECE_X],
      [PIECE_O, PIECE_X, NONE],
      [PIECE_O, NONE, PIECE_X]
    ]
    assert_equal true, vertically.win?(PIECE_O)

    # " o " で斜めが揃っている場合、ゲストの勝利になる事を担保
    diagonal = Game.new
    diagonal.board = [
      [PIECE_O, PIECE_X, PIECE_X],
      [NONE, PIECE_O, NONE],
      [PIECE_X, NONE, PIECE_O]
    ]
    assert_equal true, diagonal.win?(PIECE_O)

    # " x " で横が揃っている場合、CPUの勝利になる事を担保
    side = Game.new
    side.board = [
      [PIECE_X, PIECE_X, PIECE_X],
      [NONE, PIECE_O, PIECE_X],
      [PIECE_O, NONE, PIECE_O]
    ]
    assert_equal true, side.win?(PIECE_X)

    # " x " で縦が揃っている場合、CPUの勝利になる事を担保
    vertically = Game.new
    vertically.board = [
      [PIECE_X, NONE, PIECE_O],
      [PIECE_X, PIECE_O, NONE],
      [PIECE_X, NONE, PIECE_O]
    ]
    assert_equal true, vertically.win?(PIECE_X)

    # " x " で斜めが揃っている場合、CPUの勝利になる事を担保
    diagonal = Game.new
    diagonal.board = [
      [PIECE_X, PIECE_O, PIECE_O],
      [NONE, PIECE_X, NONE],
      [PIECE_O, NONE, PIECE_X]
    ]
    assert_equal true, diagonal.win?(PIECE_X)

    # 引き分け場合、falseが帰ってくることを担保
    draw = Game.new
    draw.board = [
      [PIECE_X, PIECE_O, PIECE_O],
      [PIECE_X, PIECE_O, PIECE_X],
      [PIECE_O, PIECE_X, PIECE_O]
    ]
    assert_equal false, draw.win?(PIECE_X)
  end

  def test_continue?
    # ボードにNONEがある場合にtrueが帰ってくる事を担保
    continue_board = Game.new
    assert_equal true, continue_board.continue?

    # ゲストが勝った場合にfalse(ゲームが継続できない状態)になる事を担保
    guest_win_board = Game.new
    guest_win_board.board = [
      [PIECE_O, PIECE_O, PIECE_O],
      [NONE, PIECE_X, PIECE_O],
      [PIECE_X, NONE, PIECE_X]
    ]
    assert_equal false, guest_win_board.continue?

    # CPUが勝った場合にfalse(ゲームが継続できない状態)になる事を担保
    cpu_win_board = Game.new
    cpu_win_board.board = [
      [PIECE_X, NONE, PIECE_O],
      [PIECE_X, PIECE_O, NONE],
      [PIECE_X, NONE, PIECE_O]
    ]
    assert_equal false, cpu_win_board.continue?

    # 引き分けの場合にfalse(ゲームが継続できない状態)になる事を担保
    draw_board = Game.new
    draw_board.board = [
      [PIECE_X, PIECE_O, PIECE_O],
      [PIECE_X, PIECE_O, PIECE_X],
      [PIECE_O, PIECE_X, PIECE_O]
    ]
    assert_equal false, draw_board.continue?
  end
end
