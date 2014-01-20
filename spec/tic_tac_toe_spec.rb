require 'spec_helper'

describe TicTacToe do
  it 'should ask about your name' do
    TicTacToe.any_instance.stub(:start_game)
    capture{ subject.should be_instance_of(TicTacToe) }.should =~ /What is your name/
  end
end
