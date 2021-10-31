class GuestPlayer < BasePlayer

  # BasePlayerのメソッドをオーバーライド
  def select_position(board)
    row,col = player_choice
  end

  private

  # 標準入力
  def player_choice
    puts "Your Turn!!"
    row = gets.to_i
    col = gets.to_i
    return row,col
  end

end
