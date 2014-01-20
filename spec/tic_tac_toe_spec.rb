require 'spec_helper'

describe TicTacToe do
  it 'should be instance of TicTacToe class' do
    TicTacToe.any_instance.stub(:start_game).and_return('A1')
    subject.should be_instance_of(TicTacToe)
  end
end
