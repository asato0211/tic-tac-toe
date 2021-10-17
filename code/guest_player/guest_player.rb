class GuestPlayer < BasePlayer

  # BasePlayerのメソッドをオーバーライド
  def select_position(board)
    row,col = guest_player_select_position(board)
  end

  private

  # 標準入力
  def player_choice
    puts "Your Turn!!"
    row = gets.to_i
    col = gets.to_i
    return row,col
  end

  # ゲストプレイヤー
  def guest_player_select_position(board)
    row,col = player_choice
    if can_place_piece?(board,row,col)
      return row,col
    else
      puts "入力値が無効です"
      guest_player_select_position(board)
    end
  end

end
