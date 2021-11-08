class GuestPlayer < BasePlayer
  # BasePlayerのメソッドをオーバーライド
  def select_position(board)
    row, col = player_choice(board)
  end

  private

  # 標準入力
  def player_choice(board)
    print '行番号を入力してください：'
    row = gets
    print '列番号を入力してください：'
    col = gets

    validate_position(row,col,board)
    [row.to_i, col.to_i]
  rescue GetsPositionError => e
    puts ""
    puts "入力項目に誤りがあります"
    puts e.message
    puts ""
    player_choice(board)
  rescue StandardError => e
    raise e
  end

end
