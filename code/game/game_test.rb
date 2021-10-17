require "minitest/autorun"
require_relative "../game/game.rb"
require_relative "../base_player/base_player.rb"
require_relative "../guest_player/guest_player.rb"
require_relative "../cpu_player/cpu_player.rb"

class GameTest < Minitest::Test

  # ゲストの駒 => " o " 、CPUの駒 => " x " になる事を担保
  def test_get_piece
    game = Game.new
    guest = GuestPlayer.new
    cpu = CpuPlayer.new

    [guest,cpu].each do |player|
      if player == guest
        assert_equal PIECE_O,game.get_piece(player.class)
      else
        assert_equal PIECE_X,game.get_piece(player.class)
      end
    end
  end

  # 3つの勝ちパターン(縦、横、斜め)で " o " が揃っている場合、ゲストの勝利になる事を担保
  def test_guest_is_win
    side = Game.new
    vertically = Game.new
    diagonal = Game.new
    (0..2).each { |i| side.board[0][i] = PIECE_O }
    (0..2).each { |i| vertically.board[i][0] = PIECE_O }
    (0..2).each { |i| diagonal.board[i][i] = PIECE_O }

    [side,vertically,diagonal].each do | status |
      assert_equal true,status.is_win?(PIECE_O)
    end
  end

  # 3つの勝ちパターン(縦、横、斜め)で " x " が揃っている場合、CPUの勝利になる事を担保
  def test_cpu_is_win
    side = Game.new
    (0..2).each { |i| side.board[0][i] = PIECE_X }
    vertically = Game.new
    (0..2).each { |i| vertically.board[i][0] = PIECE_X }
    diagonal = Game.new
    (0..2).each { |i| diagonal.board[i][i] = PIECE_X }

    [side,vertically,diagonal].each do |board|
      assert_equal true,board.is_win?(PIECE_X)
    end
  end

  # ゲストかCPUが勝利している状態、または引き分けの場合にfalse(ゲームが継続できない状態)になる事を担保
  def test_is_continue?
    guest_win_board = Game.new
    (0..2).each { |i| guest_win_board.board[0][i] = PIECE_O }
    cpu_win_board = Game.new
    (0..2).each { |i| cpu_win_board.board[0][i] = PIECE_X }
    draw_board = Game.new
    draw_board.board = [[PIECE_O,PIECE_X,PIECE_O],[PIECE_X,PIECE_O,PIECE_X],[PIECE_X,PIECE_O,PIECE_X]]
  
    [guest_win_board,cpu_win_board,draw_board].each do |board|
      assert_equal false,board.is_continue?
    end
  end
  
end