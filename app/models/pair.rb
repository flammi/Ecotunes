class Pair
  attr_accessor :first, :second

  def initialize(one, two)
    @one = one
    @two = two
  end

  def hash
    puts "<<<<<<<<<<<<<<<<<"
    puts @one.hash+@two.hash
    puts ">>>>>>>>>>>>>>>>>>"
    @one.hash+@two.hash
  end
end