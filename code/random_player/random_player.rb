class RandomPlayer < BasePlayer
  # BasePlayerのメソッドをオーバーライド
  def select_position(game)
    row, col = random_select_position(game.board)
  end

  private

  # CPU (ランダム)
  def random_select_position(board)
    row = rand(0..2)
    col = rand(0..2)
    if board[row][col] == NONE
      [row, col]
    else
      random_select_position(board)
    end
  end
end
