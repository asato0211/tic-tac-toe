class BasePlayer

  def select_position
  end
  
  private

  # 指定した座標にまだ駒が置かれていなければtrueを返す
  def can_place_piece?(board,row,col)
    return true if row >= 0 && row <= 2 && col >= 0 && col <= 2 && board[row][col] == NONE
    return false
  end

end