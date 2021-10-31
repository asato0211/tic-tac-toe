require "minitest/autorun"
require_relative "../game/game.rb"
require_relative "../base_player/base_player.rb"
require_relative "../guest_player/guest_player.rb"
require_relative "../random_player/random_player.rb"

class GameTest < Minitest::Test

  # ゲストの駒 => " o " になる事を担保
  def test_get_piece
    game = Game.new
    guest = GuestPlayer.new
    assert_equal PIECE_O,game.get_piece(guest.class)
  end

  # Rundomの駒 => " x " になる事を担保
  def test_random_get_piece
    game = Game.new
    random = RandomPlayer.new
    assert_equal PIECE_X,game.get_piece(random.class)
  end

  # ボードの中身が全てNONEの状態 --> rowに0が入るとtrueが帰ってくることを担保
  def test_return_true_row_is_0_can_place_piece?
      game = Game.new
      assert_equal true,game.can_place_piece?(0,2)
  end

  # ボードの中身が全てNONEの状態 --> colに0が入るとtrueが帰ってくることを担保
  def test_return_true_col_is_0_can_place_piece?
      game = Game.new
      assert_equal true,game.can_place_piece?(2,0)
  end

  # ボードの中身が全てNONEの状態 --> rowに3が入るとfalseが帰ってくることを担保
  def test_return_false_row_is_3_can_place_piece?
      game = Game.new
      assert_equal false ,game.can_place_piece?(3,2)
  end

  # ボードの中身が全てNONEの状態 --> colに3が入るとfalseが帰ってくることを担保
  def test_return_false_col_is_3_can_place_piece?
      game = Game.new
      assert_equal false ,game.can_place_piece?(2,3)
  end

  # ボードの中身が全てNONEの状態 --> rowに-1が入るとfalseが帰ってくることを担保
  def test_return_false_row_is_minus_onecan_place_piece?
      game = Game.new
      assert_equal false ,game.can_place_piece?(-1,2)
  end

  # ボードの中身が全てNONEの状態 --> colに-1が入るとfalseが帰ってくることを担保
  def test_return_false_col_is_minus_1_can_place_piece?
      game = Game.new
      assert_equal false ,game.can_place_piece?(2,-1)
  end

  # ボードの中身が全て埋まっている状態 --> falseが帰ってくることを担保 
  def test_board_is_full_can_place_piece?
    full_board_game = Game.new
    full_board_game.board = [
      [PIECE_O,PIECE_X,PIECE_X],
      [PIECE_X,PIECE_O,PIECE_O],
      [PIECE_X,PIECE_O,PIECE_X]
    ]
    assert_equal false ,full_board_game.can_place_piece?(1,0)
  end

  # " o " で横が揃っている場合、ゲストの勝利になる事を担保
  def test_guest_is_win_side
    side = Game.new
    side.board = [
      [PIECE_O,PIECE_O,PIECE_O],
      [NONE,PIECE_X,PIECE_O],
      [PIECE_X,NONE,PIECE_X]
    ]
    assert_equal true,side.is_win?(PIECE_O)
  end

    # " o " で縦が揃っている場合、ゲストの勝利になる事を担保
  def test_guest_is_win_vertically
    vertically = Game.new
    vertically.board = [
      [PIECE_O,NONE,PIECE_X],
      [PIECE_O,PIECE_X,NONE],
      [PIECE_O,NONE,PIECE_X]
    ]
    assert_equal true,vertically.is_win?(PIECE_O)
  end

  # " o " で斜めが揃っている場合、ゲストの勝利になる事を担保
  def test_guest_is_win_diagonal
    diagonal = Game.new
    diagonal.board = [
      [PIECE_O,PIECE_X,PIECE_X],
      [NONE,PIECE_O,NONE],
      [PIECE_X,NONE,PIECE_O]
    ]
    assert_equal true,diagonal.is_win?(PIECE_O)
  end

  # " x " で横が揃っている場合、CPUの勝利になる事を担保
  def test_cpu_is_win_side
    side = Game.new
    side.board = [
      [PIECE_X,PIECE_X,PIECE_X],
      [NONE,PIECE_O,PIECE_X],
      [PIECE_O,NONE,PIECE_O]
    ]
    assert_equal true,side.is_win?(PIECE_X)
  end

    # " x " で縦が揃っている場合、CPUの勝利になる事を担保
  def test_cpu_is_win_vertically
    vertically = Game.new
    vertically.board = [
      [PIECE_X,NONE,PIECE_O],
      [PIECE_X,PIECE_O,NONE],
      [PIECE_X,NONE,PIECE_O]
    ]
    assert_equal true,vertically.is_win?(PIECE_X)
  end

  # " x " で斜めが揃っている場合、CPUの勝利になる事を担保
  def test_cpu_is_win_diagonal
    diagonal = Game.new
    diagonal.board = [
      [PIECE_X,PIECE_O,PIECE_O],
      [NONE,PIECE_X,NONE],
      [PIECE_O,NONE,PIECE_X]
    ]
    assert_equal true,diagonal.is_win?(PIECE_X)
  end

  # 引き分け場合、falseが帰ってくることを担保
  def test_is_win_draw_game
    draw = Game.new
    draw.board = [
      [PIECE_X,PIECE_O,PIECE_O],
      [PIECE_X,PIECE_O,PIECE_X],
      [PIECE_O,PIECE_X,PIECE_O]
    ]
    assert_equal false,draw.is_win?(PIECE_X)
  end

  # ボードにNONEがある場合にtrueが帰ってくる事を担保
  def test_is_continue_return_true
    continue_board = Game.new
    assert_equal true,continue_board.is_continue?
  end

  # ゲストが勝った場合にfalse(ゲームが継続できない状態)になる事を担保
  def test_is_continue_guest_win_board
    guest_win_board = Game.new
    guest_win_board.board = [
      [PIECE_O,PIECE_O,PIECE_O],
      [NONE,PIECE_X,PIECE_O],
      [PIECE_X,NONE,PIECE_X]      
    ]
    assert_equal false,guest_win_board.is_continue?
  end

  # CPUが勝った場合にfalse(ゲームが継続できない状態)になる事を担保
  def test_is_continue_cpu_win_board
    cpu_win_board = Game.new
    cpu_win_board.board = [
      [PIECE_X,NONE,PIECE_O],
      [PIECE_X,PIECE_O,NONE],
      [PIECE_X,NONE,PIECE_O]      
    ]
    assert_equal false,cpu_win_board.is_continue?
  end

  # 引き分けの場合にfalse(ゲームが継続できない状態)になる事を担保
  def test_is_continue_draw_board
    draw_board = Game.new
    draw_board.board = [
      [PIECE_X,PIECE_O,PIECE_O],
      [PIECE_X,PIECE_O,PIECE_X],
      [PIECE_O,PIECE_X,PIECE_O]
    ]
    assert_equal false,draw_board.is_continue?
  end
  
end