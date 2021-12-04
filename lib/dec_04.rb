def dec_04(input, part)
  if part == 1
    dec_04_part_01(input)
  elsif part == 2
    dec_04_part_02(input)
  else
    raise ArgumentError.new "Part must be 1 or 2"
  end
end

def dec_04_part_01(input)
  game = Game.new(input: input)
  game.run_game
end

def dec_04_part_02(input)
end

class Game
  attr_reader :lines

  def initialize(args = {})
    @input = args[:input]
    read_file
    extract_data
  end

  def read_file
    @lines = File.readlines(@input, chomp: true)
  end

  def extract_data
    @numbers = lines.slice(0).split(/\D/).map(&:to_i)
    @lines.slice!(0..1)
    @cards = @lines.chunk { |item| item.length > 0 }
      .filter { |test, v| test }
      .map { |test, v| v.map { |item| item.split.map(&:to_i) } }
  end

  def run_game
    solution = Hash.new
    n = 4
    while n < @numbers.length && solution[:score].nil? do
      numbers_so_far = @numbers[0..n]
      @cards.each_with_index do |card, index|
        try = check_numbers(card, numbers_so_far)
        if try
          solution[:card_index] = index
          solution[:score] = try
        end
      end
      n += 1
    end
    if solution[:score]
      puts "Success! Card #{solution[:card_index]} is the winner"
      puts "With a score of #{solution[:score]}"
      return solution[:score]
    end
  end

  def check_numbers(card, numbers)
    rows_and_cols = card.clone.concat(card.transpose)
    matches = rows_and_cols.filter { |item| item.intersection(numbers).length == item.length  }.first
    if matches
      return card.flatten.filter { |item| !numbers.include?(item) }.reduce(&:+)*numbers[-1]
    end
  end
end