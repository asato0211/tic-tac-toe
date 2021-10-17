require_relative "../code/game/game.rb"
require_relative "../code/base_player/base_player.rb"
require_relative "../code/cpu_player/cpu_player.rb"
require_relative "../code/guest_player/guest_player.rb"

game = Game.new
guest = GuestPlayer.new
cpu = CpuPlayer.new

if game.is_guest_player_first?
  players = [guest,cpu]
else
  players = [cpu,guest]
end

while game.is_continue?
  players.each.with_index(1) do |player,i|
    row,col = player.select_position(game.board)
    piece = game.get_piece(player.class)
    game.put_piece(row,col,piece)
    break if game.is_continue? == false
    game.print_board if player.class == CpuPlayer && i == 1
  end
  game.print_board
end

if game.is_win?(PIECE_O)
  puts "ユーザーの勝ち!!"
elsif game.is_win?(PIECE_X)
  puts "CPUの勝ち!!" 
else
  puts "引き分け!!"
end