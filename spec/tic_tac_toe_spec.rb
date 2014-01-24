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

describe TicTacToe::User do
  it { should respond_to(:sign, :sign=) }
  it { should respond_to(:name, :name=) }
  it { should respond_to(:score, :score=) }

  it 'should have zero socre by default' do
    subject.score.should be_zero
  end
end

describe TicTacToe::User::Input do
  it { should respond_to(:turn?, :exit?) }

  it 'expty input should not be turn' do
    should_not be_turn
  end

  describe '#column, #line' do
    it 'should split user command properly' do
      described_class.new('a1').column.should == 'a'
      described_class.new('a1').line.should == '1'
    end
  end

  context '#valid?' do
    it 'exit is a valid input' do
      described_class.new('exit').should be_valid
    end

    it 'turn is a valid input' do
      described_class.new('a1').should be_valid
    end

    it "shouild be invalid if input doesn't match turn or exit" do
      described_class.new('bla-bla-bla').should_not be_valid
    end
  end

  context '#turn?' do
    let(:turns) { %w[a1 a2 a3 b1 b2 b3 c1 c2 c3] }

    it "valid turns" do
      turns.each do |turn|
        described_class.new(turn).should be_turn
      end
    end

    it 'aa or 11, not a turn' do
      described_class.new('11').should_not be_turn
      described_class.new('aa').should_not be_turn
    end

    it 'exit not a turn' do
      described_class.new('exit').should_not be_turn
    end
  end

  context '#exit?' do
    subject { described_class.new('exit') }
    it '#exit?' do
      subject.should be_exit
    end

    it 'should not be valid input' do
      subject.should_not be_turn
    end
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
