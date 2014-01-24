class TicTacToe::Board < Hash
  def height
    3
  end

  def width
    3
  end

  def draw
    puts "     a   b   c".gray
    puts ""
    puts " 1   #{self[:a1].green} | #{self[:b1].green} | #{self[:c1].green} ".gray
    puts "    --- --- ---"
    puts " 2   #{self[:a2].green} | #{self[:b2].green} | #{self[:c2].green} ".gray
    puts "    --- --- ---"
    puts " 3   #{self[:a3].green} | #{self[:b3].green} | #{self[:c3].green} ".gray
  end
end
