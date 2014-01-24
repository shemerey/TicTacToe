# coding: utf-8

TicTacToe::User = Struct.new(:name, :sign, :score) do
  def score
    @score ||= 0
  end
end
