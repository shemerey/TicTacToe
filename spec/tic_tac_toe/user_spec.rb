require 'spec_helper'

describe TicTacToe::User do
  subject { described_class.new('Anton', 'X', double) }

  it { should respond_to(:sign, :sign=) }
  it { should respond_to(:name, :name=) }
  it { should respond_to(:score, :score=) }

  it 'should have zero socre by default' do
    subject.score.should be_zero
  end
end
