require 'spec_helper'

describe TicTacToe do
  let(:input) { UserInput.new('Anton Shemerey') }
  before do
    srand(123456) # seed random and fix AI
    TicTacToe.any_instance.stub(:gets).and_return(input)
  end

  it 'should ask about your name' do
    capture{ subject.should be_instance_of(TicTacToe) }.should =~ /What is your name/
  end

  context 'Bad Game' do
    let(:input) { UserInput.new(%w[Anton a1 b1 a2 n]) }
    it 'shoud be lose' do
      capture{ subject }.should =~ /Game Over -- Ruby WINS!!!/
    end
  end

  context 'Good Game' do
    let(:input) { UserInput.new(%w[Anton c1 a1 c3 b2 n]) }
    it 'shoud be win' do
      capture{ subject }.should =~ /Game Over -- Anton WINS!!!/
    end
  end

  context 'Drawn Game' do
    let(:input) { UserInput.new(%w[Anton a1 b2 b3 c1 c2 n]) }
    it 'shoud be drawn' do
      capture{ subject }.should =~ /Game Over -- DRAW!/
    end
  end
end

describe TicTacToe::User do
  it { should respond_to(:sign, :sign=) }
  it { should respond_to(:name, :name=) }
  it { should respond_to(:score, :score=) }

  it 'should have zero socre by default' do
    subject.score.should be_zero
  end
end

describe TicTacToe::Board do
  it { should respond_to(:draw) }

  context 'Empty board' do
    it { should be_empty }
    its(:height) { should == 3 }
    its(:width) { should == 3 }
  end
end
