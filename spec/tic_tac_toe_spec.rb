require 'spec_helper'

describe TicTacToe do
  let(:input) { UserInput.new('Anton Shemerey') }
  before do
    srand(123456) # seed random and fix AI
    TicTacToe.any_instance.stub(:gets).and_return(input)
    TicTacToe::User.any_instance.stub(:gets).and_return(input)
  end

  it 'should ask about your name' do
    capture{ subject.should be_instance_of(TicTacToe) }.should =~ /What is your name/
  end

  context 'Bad Game' do
    let(:input) { UserInput.new(%w[Anton a1 b1 a3 b3]) }
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

  describe 'Error handling' do
    context "you can't go to the same cell twice" do
      let(:input) { UserInput.new(%w[Anton a1 a1]) }
      it { capture{ subject }.should =~ /You must choose an empty slot/ }
    end

    context "correct input could be column [a,b,c] line [1,2,3]" do
      let(:input) { UserInput.new(%w[Anton aa xx nn 11 12 99 a10 b20]) }
      it { capture{ subject }.should =~ /Please specify a move with the format 'A1' , 'B3' , 'C2' etc./ }
    end

    context "exit is a correct user input" do
      let(:input) { UserInput.new(%w[Anton exit]) }
      it { capture{ subject }.should_not =~ /Please specify a move with the format 'A1' , 'B3' , 'C2' etc./ }
    end
  end
end

