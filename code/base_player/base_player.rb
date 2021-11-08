require_relative '../const'

# playerの打ち手を管理するクラス
class BasePlayer
  class GetsPositionError < StandardError; end

  def select_position; end

  private

  # 概要：指定した位置に駒が置けるかどうか検証する
  # 引数：row(行番号)、col(列番号)、ボード
  # 戻り値：行または列が0~2以外の数字の場合、または既に駒が置かれている場合にエラーを返す
  def validate_position(row,col,board)
    raise GetsPositionError, "行番号の入力に誤りがあります" if row !~ /^[0-2]$/
    raise GetsPositionError, "列番号の入力に誤りがあります" if col !~ /^[0-2]$/
    raise GetsPositionError, "既に駒が置かれています" if board[row.to_i][col.to_i] != NONE
  end
end