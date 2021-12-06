def dec_06(input, part = 1)
  if part == 1
    dec_06_part_01(input)
  elsif part == 2
    dec_06_part_02(input)
  else
    raise ArgumentError.new "Part must be 1 or 2"
  end
end

def dec_06_part_01(input, days = 80)
  fish_population = FishPopulation.new(input: input)
  days.times{ fish_population.age }
  count = fish_population.count
  puts "After #{days} day(s) there are #{count} laternfish"
  return count
end

def dec_06_part_02(input)
  dec_06_part_01(input = input, days = 256) # TODO: This takes forever as needs lots of memory!
end

class Fish
  def initialize(attr = {})
    @period = attr[:period] || 7
    @timer = attr[:timer] || @period + 1
  end

  def age
    new_timer = @timer - 1
    @timer = new_timer.negative? ? @period - 1 : new_timer
  end

  def about_to_birth?
    @timer.zero?
  end
end

class FishPopulation
  def initialize(args = {})
    parse_input(args[:input])
  end

  def parse_input(input)
    ages = File.readlines(input, chomp: true).first.split(/\D/).map(&:to_i)
    @fish = ages.map { |age| Fish.new(timer: age) }
  end

  def age
    new_fish = 0
    @fish.each do |fish|
      new_fish += 1 if fish.about_to_birth?
      fish.age
    end
    new_fish.times { @fish << Fish.new }
  end

  def count
    @fish.length
  end
end
