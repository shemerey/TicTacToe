# coding: utf-8

class TicTacToe::UserInput
  attr_reader :command, :column, :line

  def initialize(input = '')
    @command = input.chomp.downcase
    @column, @line = command.split("")
  end

  def valid?
    turn? || exit?
  end

  def turn?
    ['a','b','c'].include?(column) && ['1','2','3'].include?(line)
  end

  def exit?
    :exit == command.to_sym
  end
end
