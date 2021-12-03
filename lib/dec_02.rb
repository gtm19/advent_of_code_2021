def dec_02(input, journey_class = Journey)
  journey = journey_class.new
  journey.apply_moves(input)
  journey.pos_prod
end

class Journey
  attr_reader :z, :y
  def initialize(attr = {})
    @z = attr[:z] || 0
    @y = attr[:y] || 0
  end

  def forward(n)
    @y += n.to_i
  end

  def down(n)
    @z += n.to_i
  end

  def up(n)
    @z -= n.to_i
  end

  def apply_moves(moves)
    moves_parsed = moves.map(&:split)
    moves_parsed.each do |move|
      # the send method allows calling of other methods by string or symbol
      # i.e. foo.bar(10) becomes foo.send("bar", 10)
      send(move[0], move[1])
    end
  end

  def pos_prod
    prod = @z * @y
    puts "You are at depth #{@z}"
    puts "Your horizontal position is #{@y}"
    puts "The product of these things is #{prod}"
    return prod
  end
end

class JourneyV2 < Journey
  attr_reader :aim
  def initialize(attr = {})
    super
    @aim = attr[:aim] || 0
  end

  def forward(n)
    @y += n.to_i
    @z += @aim * n.to_i
  end

  def down(n)
    @aim += n.to_i
  end

  def up(n)
    @aim -= n.to_i
  end
end