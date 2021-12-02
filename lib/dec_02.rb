def dec_02(input)

end

class Journey
  attr_reader :z, :y
  def initialize(attr = {})
    @z = attr[:z] || 0
    @y = attr[:y] || 0
  end

  def forward(n)
    @y += n
  end

  def down(n)
    @z += n
  end

  def up(n)
    @z -= n
  end

  def pos_prod
    prod = @z * @y
    puts "You are at depth #{@z}"
    puts "Your horizontal position is #{@y}"
    puts "The product of these things is #{prod}"
    return prod
  end
end