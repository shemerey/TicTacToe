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

  context '#game_draw?' do
    let(:draw_game) do
      subject[:a1], subject[:a2], subject[:a3] = 'X', 'X', 'O'
      subject[:b1], subject[:b2], subject[:b3] = 'O', 'O', 'X'
      subject[:c1], subject[:c2], subject[:c3] = 'X', 'X', 'O'
      subject
    end

    it 'should be full and no one should win' do
      draw_game.sign_win?('O').should_not be_true
      draw_game.sign_win?('X').should_not be_true
      draw_game.should be_full
      draw_game.should be_game_draw
    end

    it 'should not be draw if it some one win' do
      draw_game.stub(:sign_win?).and_return(true)
      draw_game.should_not be_game_draw
    end

    it 'should not be draw if it is not full' do
      draw_game.stub(:full?).and_return(false)
      draw_game.should_not be_game_draw
    end
  end

  context '#game_over?' do
    it 'should not be game over by default' do
      subject.should_not be_game_over
    end

    %w[1 2 3].each do |line|
      it 'was game over if someone won' do
        subject[:"a#{line}"], subject[:"b#{line}"], subject[:"c#{line}"] = 'X', 'X', 'X'
        subject.should be_game_over
      end
    end

    %w[a b c].each do |col|
      it 'was game over if someone won' do
        subject[:"#{col}1"], subject[:"#{col}2"], subject[:"#{col}3"] = 'X', 'X', 'X'
        subject.should be_game_over
      end
    end

    it 'was game over if someone won' do
      subject[:a1], subject[:b2], subject[:c3] = 'X', 'X', 'X'
      subject.should be_game_over
    end

    it 'was game over if someone won' do
      subject[:c1], subject[:b2], subject[:a3] = 'X', 'X', 'X'
      subject.should be_game_over
    end
  end

  context '#full?' do
    it { should_not be_full }
    it ' should not be full if not all cells filled' do
      subject[:a1] = 'X'
      subject.should_not be_full
    end

    it 'full if all cells filled' do
      subject[:a1], subject[:a2], subject[:a3] = 'X', 'X', 'X'
      subject[:b1], subject[:b2], subject[:b3] = 'X', 'X', 'X'
      subject[:c1], subject[:c2], subject[:c3] = 'X', 'X', 'X'
      subject.should be_full
    end
  end

  context 'default cell should be empty' do
    it '#empty?' do
      subject[:b2].should be_empty
    end

    it 'should not be empty if any cell filled' do
      subject[:a1] = 'X'
      subject.should_not be_empty
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
