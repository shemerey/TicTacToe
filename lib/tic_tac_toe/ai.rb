# coding: utf-8

class TicTacToe::Ai < TicTacToe::User

  def human?
    false
  end

  def turn
    @game.cpu_turn
  end

  def find_move
    # see if cpu can win
    #see if any winning_sequence already have 2 (cpu)
    board.wining_sequence.each do |column|
      if times_in_column(column, sign) == 2
        return empty_in_column column
      end
    end

    # see if user can win
    #see if any winning_sequence already have 2 (user)
    board.wining_sequence.each do |column|
      if times_in_column(column, opposite_sign) == 2
        return empty_in_column column
      end
    end

    #see if any winning_sequence aready have 1 (cpu)
    board.wining_sequence.each do |column|
      if times_in_column(column, sign) == 1
        return empty_in_column column
      end
    end

    #no strategic spot found so just find a random empty
    k = board.keys.sample;
    if board[board.keys.sample].empty?
      return k
    else
      #random selection is taken so just find the first empty slot
      board.each { |k,v| return k if v.empty? }
    end
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
