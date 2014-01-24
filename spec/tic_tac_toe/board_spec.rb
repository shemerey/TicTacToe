require 'spec_helper'

describe TicTacToe::Board do
  let(:board_hash) do
    {
      :a1 => '', :a2 => '', :a3 => '',
      :b1 => '', :b2 => '', :b3 => '',
      :c1 => '', :c2 => '', :c3 => '',
    }
  end

  it { should respond_to(:draw) }

  context 'like a hash' do
    it '#[]' do
      subject[:a1].should be_empty
      subject[:a1].should_not be_nil
    end

    it '#[]=' do
      subject[:a1].should be_empty
      expect {
        subject[:a1] = 'X'
      }.to change{ subject[:a1].empty? }.from(true).to(false)
    end

    it '#keys' do
      subject.keys.should == board_hash.keys
    end

    it '#values' do
      subject.values.should == board_hash.values
    end

    it '#each' do
      subject.each do |subject_cell|
        board_hash.each do |has_cell|
          subject_cell == has_cell
        end
      end
    end
  end

  context 'default cell should be empty' do
    it '#empty?' do
      subject[:b2].should be_empty
    end

    it 'should return empty cell even it outside of scope' do
      subject[:bla_bla_bla].should be_empty
    end
  end

  context 'Empty board' do

    it { should be_empty }
    its(:height) { should == 3 }
    its(:width) { should == 3 }

    it 'should eq specific hash by default' do
      subject.should == board_hash
    end
  end
end