# frozen_string_literal: true

require_relative '../code/game/game'
require_relative '../code/const'
require_relative '../code/base_player/base_player'
require_relative '../code/guest_player/guest_player'
require_relative '../code/random_player/random_player'
require_relative '../code/minimax_player/minimax_player'

game = Game.new
guest = GuestPlayer.new
minimax = MinimaxPlayer.new

players = game.guest_player_first? ? [guest, minimax] : [minimax, guest]

while game.continue?
  players.each.with_index(1) do |player, i|
    row, col = player.select_position(game)
    piece = game.get_piece(player.class)
    game.put_piece(row, col, piece)
    break if false == game.continue?

    game.print_board if player.instance_of?(MinimaxPlayer) && 1 == i
  end

  game.print_board
end

if game.win?(PIECE_O)
  puts 'ユーザーの勝ち!!'
  return
end

if game.win?(PIECE_X)
  puts 'CPUの勝ち!!'
  return
end

puts '引き分け!!'
