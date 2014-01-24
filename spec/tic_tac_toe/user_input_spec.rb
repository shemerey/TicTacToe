require 'spec_helper'

describe TicTacToe::UserInput do
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

  context '#turn' do
    it 'should return 2 chars if command is a valid turn' do
      described_class.new('a1').turn.should == :a1
      described_class.new('  a1').turn.should == :a1
      described_class.new('  a1   ').turn.should == :a1
      described_class.new('a1   ').turn.should == :a1
    end

    it 'should not return string' do
      described_class.new('  a1   ').turn.should_not == 'a1'
    end

    it 'should raise argument error if command is not valid' do
      expect{
        described_class.new('!!!!').turn
      }.to raise_error(ArgumentError)
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
