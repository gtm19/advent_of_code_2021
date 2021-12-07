def dec_07(input, part = 1)
  if part == 1
    dec_07_part_01(input)
  elsif part == 2
    dec_07_part_02(input)
  else
    raise ArgumentError.new "Part must be 1 or 2"
  end
end

def dec_07_part_01(input)
  run_efficiency(input) { |crabs| crabs.get_fuel_efficiency }
end

def dec_07_part_02(input)
  run_efficiency(input) { |crabs| crabs.get_fuel_efficiency_v2 }
end

def run_efficiency(input)
  crabs = Crabs.new(input: input)
  yield(crabs)
  # crabs.get_fuel_efficiency_v2
  efficiency = crabs.most_efficient
  puts "Position #{efficiency.keys.first} is the most efficient"
  puts "with a fuel consumption of #{efficiency.values.first}"
  return efficiency.values.first
end

class Crabs
  attr_reader :positions, :efficiency

  def initialize(args = {})
    parse_input(args[:input])
  end

  def parse_input(input)
    @positions = File.readlines(input, chomp: true).first.split(/\D/).map(&:to_i)
  end

  def get_fuel_efficiency
    potentials = @positions.min..@positions.max
    output = Hash.new(0)
    potentials.each do |potential|
      efficiency = positions.map{ |position| (position - potential).abs }.sum
      output[potential.to_s] = efficiency
    end
    @efficiency = output
  end

  def get_fuel_efficiency_v2
    potentials = @positions.min..@positions.max
    output = Hash.new(0)
    potentials.each do |potential|
      efficiency = positions.map do |position|
        steps = (position - potential).abs
        (steps * (steps + 1)) / 2
      end
      output[potential.to_s] = efficiency.sum
    end
    @efficiency = output
  end

  def most_efficient
    @efficiency.select { |k, v| v == @efficiency.values.min }
  end
end
