# frozen_string_literal: true

require_relative '../base_player/base_player'
require_relative '../minimax_player/minimax_player'
require_relative '../game/game'
require_relative '../const'
require 'rblineprof'

# rblineprofでプロファイラを導入
profile = lineprof(/./) do
  sleep 0.001

  class ProfMinimaxPlayer < BasePlayer

    # BasePlayerのメソッドをオーバーライド
    # 引数：Gameのインスタンス
    # 戻り値：Minimaxが選んだベストポジション(row,col)
    def select_position(game)
      @best_positon = []

      minimax(game, 0, PIECE_X)
      row = @best_positon[0]
      col = @best_positon[1]
      [row, col]
    end

    private

    def minimax(game, depth, piece)
      return evaluate(game, depth) if game.game_over?

      depth += 1

      scores = []     # 点数を格納する配列
      positions = []  # 座標[row,col]を格納する配列

      3.times do |row|
        3.times do |col|
          next unless game.can_place_piece?(row, col)

          possible_game = game.copy_game
          piece = get_current_piece(depth)
          possible_game.put_piece(row, col, piece)
          scores << minimax(possible_game, depth, piece)
          positions << [row, col]
        end
      end

      # depth(ゲームツリーの深さ)が奇数だったら、ミニマックスの順番とみなす
      if depth.odd?
        max_score_index = scores.each_with_index.max[1]
        @best_positon = positions[max_score_index]
        scores[max_score_index]
      else
        min_score_index = scores.each_with_index.min[1]
        @best_position = positions[min_score_index]
        scores[min_score_index]
      end
    end

    def get_current_piece(depth)
      if depth.odd?
        PIECE_X
      else
        PIECE_O
      end
    end

    # 評価関数(scores配列に点数を返す)
    def evaluate(game, depth)
      if game.win?(PIECE_X)
        10 - depth
      elsif game.win?(PIECE_O)
        depth - 10
      else
        0
      end
    end
  end

  prof = ProfMinimaxPlayer.new
  game = Game.new

  # 3マスが埋まった状態で性能テストを実施
  game.board = [
    [PIECE_O, NONE, PIECE_O],
    [NONE, PIECE_X, NONE],
    [NONE, NONE, NONE]
  ]

  prof.select_position(game)

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
