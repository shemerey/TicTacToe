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

    @user_object, @cpu_object = User.new(gets.chomp, 'X', self), Ai.new('Ruby', 'O', self)

    @users = [
       @user_object,
       @cpu_object
    ]

    put_bar
    user_object.turn
  end

  def players
    @users.shuffle.circle.each
  end

  def restart_game
    clean && user_object.turn
  end

  def wrong_input
    put_line
    puts " Please specify a move with the format 'A1' , 'B3' , 'C2' etc.".red
    user_object.turn
  end

  def wrong_move
    put_line
    puts " You must choose an empty slot".red
    user_object.turn
  end

  def play(user)
    user.turn unless board.game_over?
    finish(draw_message) if board.game_draw?
  end

  def put_line
    puts ("-" * 80).gray
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

  def finish(message)
    message && ask_to_play_again
  end

  def put_bar
    puts ("#" * 80).gray
    puts ("#" * 80).gray
  end

  def clean
    (1...20).each { |i| put_line }
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
end

  if __FILE__ == $PROGRAM_NAME
    TicTacToe.new
  end
