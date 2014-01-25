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

    @user_object, @cpu_object = User.new(gets.chomp, 'X', board), Ai.new('Ruby', 'O', board)

    @users = [
       @user_object,
       @cpu_object
    ]

    put_bar
    user_turn
  end

  def players
    @users.shuffle.circle.each
  end

  def restart_game
    clean && user_turn
  end

  def cpu_turn
    move = cpu_object.find_move
    board[move] = cpu_object.sign
    put_line
    puts " #{cpu_object.name} marks #{move.to_s.upcase.green}".neon
    if board.sign_win?(cpu_object.sign)
      draw_game
      cpu_object.score += 1
      finish(win_message(cpu_object))
    end
    play(user_object)
  end

  def turn(user)
    if user.human?
      user_turn
    else
      cpu_turn
    end
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
      if board.sign_win?(user_object.sign)
        draw_game
        user_object.score += 1
        finish(win_message(user_object))
      end
      play(cpu_object)
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

  def play(user)
    turn(user) unless board.game_over?
    finish(draw_message) if board.game_draw?
  end


  private

    def finish(message)
      message && ask_to_play_again
    end

    def ask_to_play_again
      restart_game if paly_again?
    end

    def paly_again?
      print " Play again? (Yn): "
      STDOUT.flush
      case gets.chomp.downcase
      when "y"   then true
      when "yes" then true
      when "n"   then false
      when "no"  then false
      else paly_again?
      end
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

    def clean
      (1...20).each { |i| put_line }
    end

    def draw_message
      draw_game
      put_line
      puts ""
      puts " Game Over -- DRAW!\n".blue
    end

    def win_message(user)
      put_line
      puts ""
      puts " Game Over -- #{user.name} WINS!!!\n".blue
    end

    def draw_game
      put_line
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
