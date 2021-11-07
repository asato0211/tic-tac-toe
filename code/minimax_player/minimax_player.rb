require_relative '../game/game'

class MinimaxPlayer < BasePlayer
  def initialize
    @best_positon = []
    @turn_count = 0
  end

  # BasePlayerのメソッドをオーバーライド
  def select_position(game)
    minimax_player_select_position(game, 0)
    row = best_positon[0]
    col = best_positon[1]
    [row, col]
  end

  # 一番最善の一手を返す（row,col）
  def minimax_player_select_position(game, depth)
    puts game.continue?
    return evaluate_state(game, depth) if game.continue? == false

    depth += 1
    @turn_count += 1

    piece = PIECE_O if @turn_count.odd?

    scores = [] # 点数を格納していく
    positions = [] # NONEの座標をpositions[]に格納していく

    3.times do |row|
      3.times do |col|
        next unless can_place_piece?(game.board, row, col)

        possible_game = game.get_new_game_state(row, col, piece)
        scores << minimax_player_select_position(possible_game, depth)
        positions << [row, col]
      end
    end

    # 生成された状態ごとに点数が格納された配列から、minまたはmaxを求める
    if piece == PIECE_X
      max_score_index = scores.each_with_index.max[1]
      @best_positon = positions[max_score_index]
      scores[max_score_index]
    else
      min_score_index = scores.each_with_index.min[1]
      @best_position = positions[min_score_index]
      scores[min_score_index]
    end
  end

  # 評価関数（ゲームツリーの深さに応じて点数をつける)
  def evaluate_state(game, depth)
    if game.win?(PIECE_O)
      10 - depth
    elsif game.minimax_is_lose?(PIECE_O)
      depth - 10
    else
      0
    end
  end
end
