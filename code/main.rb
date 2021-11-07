require_relative '../code/game/game'
require_relative '../code/base_player/base_player'
require_relative '../code/guest_player/guest_player'
require_relative '../code/random_player/random_player'

game = Game.new
guest = GuestPlayer.new
random = RandomPlayer.new

players = if game.guest_player_first?
            [guest, random]
          else
            [random, guest]
          end

while game.continue?
  players.each.with_index(1) do |player, i|
    row, col = player.select_position(game.board)
    piece = game.get_piece(player.class)
    redo unless game.can_place_piece?(row, col)
    game.put_piece(row, col, piece)
    break if game.continue? == false

    game.print_board if player.instance_of?(RandomPlayer) && i == 1
  end
  game.print_board
end

if game.win?(PIECE_O)
  puts 'ユーザーの勝ち!!'
elsif game.win?(PIECE_X)
  puts 'CPUの勝ち!!'
else
  puts '引き分け!!'
end
