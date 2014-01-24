# coding: utf-8

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

class TicTacToe; end

require "color_text"
require 'tic_tac_toe/all'

class TicTacToe
  attr_reader :cpu_object, :user_object, :board

  def initialize
    @board = Board.new

    greeting

    @user_object, @cpu_object = User.new(gets.chomp, signs.last, board), User.new('Ruby', signs.first, board)

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
    cpu_object.find_move
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

  def user_turn
    put_line
    puts "\n  RUBY TIC TAC TOE".purple
    draw_game
    print "\n #{user_object.name}, please make a move or type 'exit' to quit: ".neon
    STDOUT.flush

    return wrong_input unless (user_input = UserInput.new(gets.chomp.downcase)).valid?

    put_bar

    if user_input.turn?
      return wrong_move unless board[user_input.turn].empty?
      board[user_input.turn] = user_object.sign
      put_line
      puts " #{user_object.name} marks #{user_input.turn.to_s.upcase.green}".neon
      check_game(cpu_object.sign)
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

  def check_game(next_turn)

    game_over = nil

    board.wining_sequence.each do |column|
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
      unless board.full?
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
