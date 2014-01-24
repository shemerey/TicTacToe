class TicTacToe::Board
  extend Forwardable

  def_delegators :@board, :size, :<<, :map, :each, :keys, :values, :[]=

  def initialize(*)
    @board = {
      :a1 => '', :a2 => '', :a3 => '',
      :b1 => '', :b2 => '', :b3 => '',
      :c1 => '', :c2 => '', :c3 => '',
    }
  end

  def height
    3
  end

  def width
    3
  end

  def [](key)
    @board.fetch(key) { '' }
  end

  def ==(other)
    @board == other
  end

  def empty?
    values.all?(&:empty?)
  end

  def full?
    values.all? {|v| not v.empty? }
  end

  def wining_sequence
    @winning_sequence ||= [
      [:a1,:a2,:a3],
      [:b1,:b2,:b3],
      [:c1,:c2,:c3],

      [:a1,:b1,:c1],
      [:a2,:b2,:c2],
      [:a3,:b3,:c3],

      [:a1,:b2,:c3],
      [:c1,:b2,:a3]
    ]
  end

  def game_over?
    full? || signs.any?{ |sign| sign_win?(sign) }
  end

  def draw?
    signs.all?{ |sign| full? && (not sign_win?(sign)) }
  end

  def sign_win?(sign)
    wining_sequence.any? do |column|
      times_in_column(column, sign) == 3
    end
  end

  def draw
    puts "     a   b   c".gray
    puts ""
    puts " 1   #{@board[:a1].green} | #{@board[:b1].green} | #{@board[:c1].green} ".gray
    puts "    --- --- ---"
    puts " 2   #{@board[:a2].green} | #{@board[:b2].green} | #{@board[:c2].green} ".gray
    puts "    --- --- ---"
    puts " 3   #{@board[:a3].green} | #{@board[:b3].green} | #{@board[:c3].green} ".gray
  end

  private

    def signs
      values.delete_if(&:empty?).uniq
    end

    def times_in_column arr, item
      times = 0
      arr.each do |i|
        times += 1 if @board[i] == item
        unless @board[i] == item || @board[i].empty?
          #oppisite piece is in column so column cannot be used for win.
          #therefore, the strategic thing to do is choose a dif column so return 0.
          return 0
        end
      end
      times
    end
end
