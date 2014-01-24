require 'spec_helper'

describe TicTacToe::Board do
  it { should respond_to(:draw) }

  context 'Empty board' do
    it { should be_empty }
    its(:height) { should == 3 }
    its(:width) { should == 3 }
  end
end
