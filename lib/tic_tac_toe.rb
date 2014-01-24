require "color_text"

class TicTacToe
  attr_reader :cpu_object, :user_object

  User = Struct.new(:name, :sign, :score) do
    def score
      @score ||= 0
    end
  end

  class Board < Hash

    def height
      3
    end

    def width
      3
    end

    def draw
      puts "     a   b   c".gray
      puts ""
      puts " 1   #{self[:a1].green} | #{self[:b1].green} | #{self[:c1].green} ".gray
      puts "    --- --- ---"
      puts " 2   #{self[:a2].green} | #{self[:b2].green} | #{self[:c2].green} ".gray
      puts "    --- --- ---"
      puts " 3   #{self[:a3].green} | #{self[:b3].green} | #{self[:c3].green} ".gray
    end
  end

  def initialize
    greeting

    @user_object, @cpu_object = User.new(gets.chomp, signs.last), User.new('Ruby', signs.first)

    put_bar
    start_game(user_object.sign == 'X')
  end

  def start_game(user_goes_first)
    if user_goes_first
      user_turn
    else
      cpu_turn
    end
  end

  def restart_game(user_goes_first)
    (1...20).each { |i| put_line }
    start_game(user_goes_first)
  end

  def cpu_turn
    move = cpu_find_move
    board[move] = cpu_object.sign
    put_line
    puts " #{cpu_object.name} marks #{move.to_s.upcase.green}".neon
    check_game(user_object.sign)
  end

  def cpu_find_move

    # see if cpu can win
    #see if any winning_sequence already have 2 (cpu)
    winning_sequence.each do |column|
      if times_in_column(column, cpu_object.sign) == 2
        return empty_in_column column
      end
    end

    # see if user can win
    #see if any winning_sequence already have 2 (user)
    winning_sequence.each do |column|
      if times_in_column(column, user_object.sign) == 2
        return empty_in_column column
      end
    end

    #see if any winning_sequence aready have 1 (cpu)
    winning_sequence.each do |column|
      if times_in_column(column, cpu_object.sign) == 1
        return empty_in_column column
      end
    end

    #no strategic spot found so just find a random empty
    k = board.keys;
    i = rand(k.length)
    if board[k[i]] == " "
      return k[i]
    else
      #random selection is taken so just find the first empty slot
      board.each { |k,v| return k if v == " " }
    end
  end

  def times_in_column arr, item
    times = 0
    arr.each do |i|
      times += 1 if board[i] == item
      unless board[i] == item || board[i] == " "
        #oppisite piece is in column so column cannot be used for win.
        #therefore, the strategic thing to do is choose a dif column so return 0.
        return 0
      end
    end
    times
  end

  def empty_in_column arr
    arr.each do |i|
      if board[i] == " "
        return i
      end
    end
  end

  def user_turn
    put_line
    puts "\n  RUBY TIC TAC TOE".purple
    draw_game
    print "\n #{user_object.name}, please make a move or type 'exit' to quit: ".neon
    STDOUT.flush
    input = gets.chomp.downcase.to_sym
    put_bar
    if input.length == 2
      a = input.to_s.split("")
      if (['a','b','c'].include? a[0]) && (['1','2','3'].include? a[1])
        if board[input] == " "
          board[input] = user_object.sign
          put_line
          puts " #{user_object.name} marks #{input.to_s.upcase.green}".neon
          check_game(cpu_object.sign)
        else
          wrong_move
        end
      else
        wrong_input
      end
    else
      wrong_input unless input == :exit
    end
  end

  def wrong_input
    put_line
    puts " Please specify a move with the format 'A1' , 'B3' , 'C2' etc.".red
    user_turn
  end

  def wrong_move
    put_line
    puts " You must choose an empty slot".red
    user_turn
  end

  def moves_left
    board.values.select{ |v| v == " " }.length
  end

  def check_game(next_turn)

    game_over = nil

    winning_sequence.each do |column|
      # see if cpu has won
      if times_in_column(column, cpu_object.sign) == 3
        put_line
        draw_game
        put_line
        puts ""
        puts " Game Over -- #{cpu_object.name} WINS!!!\n".blue
        game_over = true
        cpu_object.score += 1
        ask_to_play_again(false)
      end
      # see if user has won
      if times_in_column(column, user_object.sign) == 3
        put_line
        draw_game
        put_line
        puts ""
        puts " Game Over -- #{user_object.name} WINS!!!\n".blue
        game_over = true
        user_object.score += 1
        ask_to_play_again(true)
      end
    end

    unless game_over
      if(moves_left > 0)
        if(next_turn == user_object.sign)
          user_turn
        else
          cpu_turn
        end
      else
        put_line
        draw_game
        put_line
        puts ""
        puts " Game Over -- DRAW!\n".blue
        ask_to_play_again(rand() > 0.5)
      end
    end
  end

  def ask_to_play_again(user_goes_first)
    print " Play again? (Yn): "
    STDOUT.flush
    response = gets.chomp.downcase
    case response
    when "y"   then restart_game(user_goes_first)
    when "yes" then restart_game(user_goes_first)
    when "n"   then #do nothing
    when "no"  then #do nothing
    else ask_to_play_again(user_goes_first)
    end
  end

  private

    def signs
      @signs ||= rand() > 0.5 ? %w[X O] : %w[O X]
    end


    def board
      #the tic tac toe slots
      @board ||= Board[
        a1: " ", a2:" ",a3:" ",
        b1: " ", b2:" ",b3:" ",
        c1: " ", c2:" ",c3:" ",
      ]
    end

    def winning_sequence
      @winning_sequence ||= [
        [:a1,:a2,:a3],
        [:b1,:b2,:b3],
        [:c1,:c2,:c3],

        [:a1,:b1,:c1],
        [:a2,:b2,:c2],
        [:a3,:b3,:c3],

        [:a1,:b2,:c3],
        [:c1,:b2,:a3]
      ]
    end

    def greeting
      put_line
      puts "\n  RUBY TIC TAC TOE".purple
      print "\n What is your name? ".neon
      STDOUT.flush
    end

    def put_line
      puts ("-" * 80).gray
    end

    def put_bar
      puts ("#" * 80).gray
      puts ("#" * 80).gray
    end

    def draw_game
      puts ""
      puts " Wins: #{user_object.name}:#{user_object.score} #{cpu_object.name}:#{cpu_object.score}".gray
      puts ""
      puts " #{user_object.name}: #{user_object.sign.green}"
      puts " #{cpu_object.name}: #{cpu_object.sign.green}"
      puts ""
      board.draw
    end
end

  if __FILE__ == $PROGRAM_NAME
    TicTacToe.new
  end
