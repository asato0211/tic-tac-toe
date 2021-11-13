require_relative '../const'

# ゲームの進行状況を管理するクラス
class Game
  attr_accessor :board

  def initialize
    @board = Array.new(3) { Array.new(3, NONE) }
  end

  # guest_playerが先攻を選んだ場合にtrueを返す
  def guest_player_first?
    puts <<-TEXT
    先攻か後攻を選んで下さい！
    (1 => 先攻、2 => 後攻)
    TEXT
    gets_result = gets
    case gets_result.to_i
    when 1
      true
    when 2
      false
    else
      guest_player_first?
    end
  end

  def get_piece(player)
    if player == GuestPlayer
      PIECE_O
    else
      PIECE_X
    end
  end

  # 指定した座標にまだ駒が置かれていなければtrueを返す
  def can_place_piece?(row, col)
    return true if row >= 0 && row <= 2 && col >= 0 && col <= 2 && @board[row][col] == NONE

    false
  end

  def put_piece(row, col, piece)
    @board[row][col] = piece
  end

  # 勝利判定
  def win?(piece)
    return true if piece == @board[0][0] && piece == @board[0][1] && piece == @board[0][2]
    return true if piece == @board[1][0] && piece == @board[1][1] && piece == @board[1][2]
    return true if piece == @board[2][0] && piece == @board[2][1] && piece == @board[2][2]
    return true if piece == @board[0][0] && piece == @board[1][0] && piece == @board[2][0]
    return true if piece == @board[0][1] && piece == @board[1][1] && piece == @board[2][1]
    return true if piece == @board[0][2] && piece == @board[1][2] && piece == @board[2][2]
    return true if piece == @board[0][0] && piece == @board[1][1] && piece == @board[2][2]
    return true if piece == @board[0][2] && piece == @board[1][1] && piece == @board[2][0]

    return false
  end

  # まだ勝敗がついていないかつ、ボードが埋まっていない場合にtrueを返す
  def continue?
    return false if win?(PIECE_O)
    return false if win?(PIECE_X)
    return false unless exists_empty_space

    return true
  end

  # ボードを出力
  def print_board
    puts <<-BOARD

    #{@board[0][0]}|#{@board[0][1]}|#{@board[0][2]}
    -----------
    #{@board[1][0]}|#{@board[1][1]}|#{@board[1][2]}
    -----------
    #{@board[2][0]}|#{@board[2][1]}|#{@board[2][2]}

    BOARD
  end

  private

  # ボードに空き(NONE)がある場合にtrueを返す
  def exists_empty_space
    3.times do |i|
      3.times do |j|
        return true if @board[i][j] == NONE
      end
    end
    false
  end
end
