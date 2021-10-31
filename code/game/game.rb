PIECE_O = " o "
PIECE_X = " x "
NONE    = "   "

class Game
  attr_accessor :board

  def initialize
    @board = Array.new(3) { Array.new(3,NONE) }
  end

  # guest_playerが先攻を選んだ場合にtrueを返す
  def is_guest_player_first?
    puts <<-TEXT
    先攻か後攻を選んで下さい！
    (1 => 先攻、2 => 後攻)
    TEXT
    gets_result = gets.to_i
    if gets_result == 1
      return true
    elsif gets_result == 2
      return false
    else
      is_guest_player_first?
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
  def can_place_piece?(row,col)
    return true if row >= 0 && row <= 2 && col >= 0 && col <= 2 && @board[row][col] == NONE
    return false
  end

  def put_piece(row,col,piece)
    @board[row][col] = piece
  end

  # Minimax
  def get_new_game_state(row,col,piece)
    tmp_game = Marshal.dump(@board)
    copy_game = Marshal.load(tmp_game)
    copy_game[row][col] = piece
  end

  def minimax_is_lose?
    return true if is_win?(PIECE_O)
    return false
  end

  # 勝利判定
  def is_win?(piece)
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
  def is_continue?
    if is_win?(PIECE_O)
      return false
    elsif is_win?(PIECE_X)
      return false
    elsif is_empty? == false
      return false
    end
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
  def is_empty?
    3.times do |i|
      3.times do |j|
        return true if @board[i][j] == NONE
      end
    end
    return false
  end
  
end