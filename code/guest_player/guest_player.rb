class GuestPlayer < BasePlayer
  # BasePlayerのメソッドをオーバーライド
  def select_position(game)
    row, col = player_choice(game.board)
  end

  private

  # 標準入力
  def player_choice(board)
    print '行番号を入力してください：'
    row = gets.to_i
    print '列番号を入力してください：'
    col = gets.to_i

    validate_position(row,col,board)
    [row, col]
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
