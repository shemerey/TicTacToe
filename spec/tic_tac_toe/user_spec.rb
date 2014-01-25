require 'spec_helper'

describe TicTacToe::User do
  before { srand(123456) }
  subject { described_class.new('Anton', 'X', double) }

  it { should respond_to(:sign, :sign=) }
  it { should respond_to(:name, :name=) }
  it { should respond_to(:score, :score=) }

  it 'should have zero socre by default' do
    subject.score.should be_zero
  end

  describe '#human?' do
    it{ subject.should be_human }
    it 'should not be human if user name Ruby' do
      subject.stub(:name).and_return('Ruby')
      subject.should_not be_human
    end
  end
end
