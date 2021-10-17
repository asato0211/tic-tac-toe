class CpuPlayer < BasePlayer

  # BasePlayerのメソッドをオーバーライド
  def select_position(board)
    row,col = cpu_select_position(board)
  end

  private

  # CPU (ランダム)
  def cpu_select_position(board)
    row = rand(0..2)
    col = rand(0..2)
    if board[row][col] == NONE
      return row,col
    else
      cpu_select_position(board)
    end
  end
end
