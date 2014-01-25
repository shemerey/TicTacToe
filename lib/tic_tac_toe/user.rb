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
    @game.put_line
    puts "\n  RUBY TIC TAC TOE".purple
    @game.draw_game
    print "\n #{name}, please make a move or type 'exit' to quit: ".neon
    STDOUT.flush

    return @game.wrong_input unless (user_input = TicTacToe::UserInput.new(gets.chomp.downcase)).valid?

    @game.put_bar

    if user_input.turn?
      return @game.wrong_move unless board[user_input.turn].empty?
      board[user_input.turn] = sign
      @game.put_line
      puts " #{name} marks #{user_input.turn.to_s.upcase.green}".neon
      if board.sign_win?(sign)
        @game.draw_game
        self.score += 1
        @game.finish(@game.win_message(self))
      end
      @game.play(@game.cpu_object)
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
