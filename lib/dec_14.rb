def dec_14(input, part = 1)
  if part == 1
    dec_14_part_01(input)
  elsif part == 2
    dec_14_part_02(input)
  else
    raise ArgumentError.new "Part must be 1 or 2"
  end
end

def dec_14_part_01(input)
  dec_14_run(input, 10)
end

def dec_14_part_02(input)
  dec_14_run(input, 40)
end

def dec_14_run(input, n)
  polymer = Polymers.new(input: input)
  n.times { polymer.step }
  score = polymer.score
  puts "After #{n} steps, the polymer score is #{score}"
  return score
end

class Polymers
  attr_reader :polymer, :rules, :tally
  def initialize **args
    @input = args[:input] || File.join("inputs", "test", "test_dec_14.txt")
    parse_input
  end

  def step
    # Start afresh
    new_tally = Hash.new(0)
    @tally.each do |k, v|
      # say k = ["N", "N"] and v = 1
      # our new letter will be "C"
      new_letter = @rules[k.join]
      # ["N", "N"] will be replaced by ["N", "C"] and ["C", "N"]
      # in other words, an ["N", "C"] and ["C", "N"] will be created
      # once for each ["N", "N"] which previously existed
      # ["N", "N"] already has zero value in the new world because
      # new_tally starts from scratch
      new_tally[[k[0], new_letter]] += v
      new_tally[[new_letter, k[1]]] += v
    end
    @tally = new_tally
  end

  def score
    scores = Hash.new(0)
    # add up the counts for the first letter of each pair
    # to prevent double counting
    @tally.each { |k, v| scores[k[0]] += v }
    # doing so will omit the last letter of the initial polymer,
    # so add one to this count
    scores[@polymer[-1]] += 1

    min_max = scores.values.minmax
    (min_max[1] - min_max[0]).abs
  end

  private

  def parse_input
    lines = File.readlines(@input, chomp: true).reject(&:empty?)
    @polymer = lines.shift
    @rules = {}

    lines.each do |line|
      split = line.split(/ -> /)
      @rules[split[0]] = split[1]
    end

    @tally = @polymer.chars.each_cons(2).tally
    @tally.default = 0
  end
end