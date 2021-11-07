class GuestPlayer < BasePlayer
  # BasePlayerのメソッドをオーバーライド
  def select_position(_board)
    row, col = player_choice
  end

  private

  # 標準入力
  def player_choice
    puts 'Your Turn!!'
    row = gets
    col = gets
    [row.to_i, col.to_i]
  end
end
