class TicTacToe::Board < Hash
  extend Forwardable

  def_delegators :@board, :size, :<<, :map, :each, :keys, :values, :[]=

  def initialize(*)
    @board = {
      :a1 => '', :a2 => '', :a3 => '',
      :b1 => '', :b2 => '', :b3 => '',
      :c1 => '', :c2 => '', :c3 => '',
    }
    super
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

  def winning_sequence
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

  def draw
    puts "     a   b   c".gray
    puts ""
    puts " 1   #{@board[:a1].green} | #{@board[:b1].green} | #{@board[:c1].green} ".gray
    puts "    --- --- ---"
    puts " 2   #{@board[:a2].green} | #{@board[:b2].green} | #{@board[:c2].green} ".gray
    puts "    --- --- ---"
    puts " 3   #{@board[:a3].green} | #{@board[:b3].green} | #{@board[:c3].green} ".gray
  end
end
