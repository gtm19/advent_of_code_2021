def dec_08(input, part = 1)
  if part == 1
    dec_08_part_01(input)
  elsif part == 2
    dec_08_part_02(input)
  else
    raise ArgumentError.new "Part must be 1 or 2"
  end
end

def dec_08_part_01(input)
  digits = Digits.new(input: input)
  simple_digits = digits.simple_digits
  puts "There are #{simple_digits} simple digits in the output"
  return simple_digits
end

def dec_08_part_02(input)

end

class Digits
  attr_reader :entries

  def initialize(args = {})
    @input = args[:input]
    parse_input
  end

  def parse_input
    @entries = File.readlines(@input, chomp: true).map do |item|
      item_split = item.split(/ \| /)
      item_split.map(&:split)
    end
  end

  def simple_digits(lengths = [2, 3, 4, 7])
    simple_digits = @entries.map do |item|
      output = item[1]
      output.filter{ |digit| lengths.include?(digit.length) }.length
    end
    simple_digits.sum
  end
end
