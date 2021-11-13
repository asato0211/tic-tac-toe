require_relative '../game/game'
require_relative '../const'

class MinimaxPlayer < BasePlayer
  def initialize
    @call_minimax_count = 0
  end
  
  def get_next_piece(dept)
    if dept.odd?
      @current_player_piece = PIECE_X
    else
      @current_player_piece = PIECE_O
    end
  end
  
  # BasePlayerのメソッドをオーバーライド
  def select_position(game)
    @best_positon = []
    @current_player_piece = PIECE_X   
    
    minimax_player_select_position(game,0)
    row = @best_positon[0]
    col = @best_positon[1]
    [row, col]
  end
  
  
  # 一番最善の一手を返す（row,col）
  def minimax_player_select_position(game,depth)
    return score(game,depth) unless game.continue?
    depth += 1
    
    scores = []
    positions = []
    
    3.times do |row|
      3.times do |col|
        next unless game.board[row][col] == NONE
        possible_game = Marshal.load(Marshal.dump(game))
        get_next_piece(depth)
        possible_game.board[row][col] = @current_player_piece
        scores << minimax_player_select_position(possible_game,depth)
        positions << [row, col]
      end
    end

    # 生成された状態ごとに点数が格納された配列から、minまたはmaxを求める
    if @current_player_piece == PIECE_X
      max_score_index = scores.each_with_index.max[1]
      @best_positon = positions[max_score_index]
      return scores[max_score_index]
    else
      min_score_index = scores.each_with_index.min[1]
      @best_position = positions[min_score_index]
      return scores[min_score_index]
    end
  end

  # minimaxが勝った場合はプラス10点、guestが勝ったらマイナス10点、そうでなければ0点を返す
  def score(game,depth)
    if game.win?(PIECE_X)
      return 10 - depth
    elsif game.win?(PIECE_O)
      return depth - 10
    else
      return 0
    end
  end

end