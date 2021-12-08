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
  digits = Digits.new(input: input)
  values_sum = digits.get_values.sum
  puts "The sum of all the output values is #{values_sum}"
  return values_sum
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

  def get_values
    @entries.map do |item|
      decoder = decode_line(item)
      output_code = item[1]
      digits = output_code.map do |encoded_digit|
        digit_split = encoded_digit.split(//).sort
        decoder.select{ |k, v| v == digit_split }.keys.first
      end
      digits.join.to_i
    end
  end

  private

  def decode_line(line)
    input_digits = line[0]
    output = Hash.new(0)
    output["1"] = input_digits.select { |item| item.length == 2 }.first.split(//).sort
    output["4"] = input_digits.select { |item| item.length == 4 }.first.split(//).sort
    output["7"] = input_digits.select { |item| item.length == 3 }.first.split(//).sort
    output["8"] = input_digits.select { |item| item.length == 7 }.first.split(//).sort
    output["2"] = input_digits.select do |item|
      item_split = item.split(//)
      item.length == 5 && (item_split & output["1"]).length == 1 && (item_split & output["4"]).length == 2
    end.first.split(//).sort
    output["3"] = input_digits.select do |item|
      item_split = item.split(//)
      item.length == 5 && (item_split & output["1"]).length == 2 && (item_split & output["4"]).length == 3
    end.first.split(//).sort
    output["5"] = input_digits.select do |item|
      item_split = item.split(//)
      item.length == 5 && (item_split & output["1"]).length == 1 && (item_split & output["4"]).length == 3
    end.first.split(//).sort
    output["6"] = input_digits.select do |item|
      item_split = item.split(//)
      item.length == 6 && (item_split & output["1"]).length == 1 && (item_split & output["4"]).length == 3
    end.first.split(//).sort
    output["9"] = input_digits.select do |item|
      item_split = item.split(//)
      item.length == 6 && (item_split & output["1"]).length == 2 && (item_split & output["4"]).length == 4
    end.first.split(//).sort
    output["0"] = input_digits.select do |item|
      item_split = item.split(//)
      item.length == 6 && (item_split & output["1"]).length == 2 && (item_split & output["4"]).length == 3
    end.first.split(//).sort
    output
  end
end
