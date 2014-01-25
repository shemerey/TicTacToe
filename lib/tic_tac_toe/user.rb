# coding: utf-8

class TicTacToe::User
  attr_accessor :name, :sign, :score, :board

  def initialize(name, sign, game)
    @name, @sign, @game = name, sign, game
  end

  def score
    @score ||= 0
  end

  def human?
    true
  end

  def board
    @board ||= @game.board
  end

  def turn
    @game.user_turn
  end

  private

    def empty_in_column arr
      arr.each do |i|
        if board[i].empty?
          return i
        end
      end
    end

    def opposite_sign
      %w[X O].detect{|s| s != sign }
    end

    def times_in_column arr, item
      times = 0
      arr.each do |i|
        times += 1 if board[i] == item
        unless board[i] == item || board[i].empty?
          #oppisite piece is in column so column cannot be used for win.
          #therefore, the strategic thing to do is choose a dif column so return 0.
          return 0
        end
      end
      times
    end
end
