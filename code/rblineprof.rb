# frozen_string_literal: true

require_relative '../code/game/game'
require_relative '../code/const'
require_relative '../code/base_player/base_player'
require_relative '../code/guest_player/guest_player'
require_relative '../code/random_player/random_player'
require_relative '../code/minimax_player/minimax_player'
require 'rblineprof'

# rblineprofでプロファイラを導入
profile = lineprof(/./) do
  sleep 0.001

  game = Game.new
  random = RandomPlayer.new
  minmax = MinimaxPlayer.new

  players = [random, minmax]

  while game.continue?
    players.each.with_index(1) do |player, i|
      row, col = player.select_position(game)
      piece = game.get_piece(player.class)
      if player.class == RandomPlayer
        piece = PIECE_O
      end
      game.put_piece(row, col, piece)
      break if game.continue? == false

      game.print_board if player.instance_of?(MinimaxPlayer) && i == 1
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

end

file = profile.keys.first

# 「CPU時間, Idle時間(実際の経過時間(Wall) - CPU時間), 呼び出し回数」
# プログラム一行ごとに上記の数値を出力
File.readlines(file).each_with_index do |line, num|
  wall, cpu, calls, allocations = profile[file][num + 1]

  if wall > 0 || cpu > 0 || calls > 0
    printf(
      "% 5.1fms + % 6.1fms (% 4d) | %s",
      cpu / 1000.0,
      (wall - cpu) / 1000.0,
      calls,
      line
    )
  else
    printf "                          | %s", line
  end
end
