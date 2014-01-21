require 'spec_helper'

class UserInput
  def initialize(commands = nil)
    @commands = Array(commands)
  end

  def chomp
    @commands.shift || 'exit'
  end
end

describe TicTacToe do
  let(:input) { UserInput.new('Anton') }
  before { TicTacToe.any_instance.stub(:gets).and_return(input) }

  it 'should ask about your name' do
    capture{ subject.should be_instance_of(TicTacToe) }.should =~ /What is your name/
  end
end
