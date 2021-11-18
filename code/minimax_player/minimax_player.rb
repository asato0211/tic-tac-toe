require_relative '../game/game'
require_relative '../const'

class MinimaxPlayer < BasePlayer
  
  # BasePlayerのメソッドをオーバーライド
  # 引数：Gameのインスタンス
  # 戻り値：Minimaxが選んだベストポジション(row,col)
  def select_position(game)
    @best_positon = []
    
    minimax(game,0,PIECE_X)
    row = @best_positon[0]
    col = @best_positon[1]
    return [row, col]
  end
  
  def minimax(game,depth,piece)
    return evaluate(game,depth) unless game.continue?
    depth += 1
    
    scores = []     # 点数を格納する配列
    positions = []  # 座標[row,col]を格納する配列
    
    3.times do |row|
      3.times do |col|
        next unless game.board[row][col] == NONE
        possible_game = Marshal.load(Marshal.dump(game))
        piece = get_current_piece(depth)
        possible_game.board[row][col] = piece
        scores << minimax(possible_game,depth,piece)
        positions << [row, col]
      end
    end
    
    # depth(深さ)が奇数だったら、ミニマックスの順番とみなす
    if depth.odd?
      max_score_index = scores.each_with_index.max[1]
      @best_positon = positions[max_score_index]
      return scores[max_score_index]
    else
      min_score_index = scores.each_with_index.min[1]
      @best_position = positions[min_score_index]
      return scores[min_score_index]
    end
  end

  private
  
  def get_current_piece(depth)
    if depth.odd?
      PIECE_X
    else
      PIECE_O
    end
  end

  # 評価関数(scores配列に点数を返す)
  def evaluate(game,depth)
    if game.win?(PIECE_X)
      return 10 - depth
    elsif game.win?(PIECE_O)
      return depth - 10
    else
      return 0
    end
  end
  
end
