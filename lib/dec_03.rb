def dec_03(input, part = 1)
  if part == 1
    dec_03_part_01(input)
  elsif part == 2
    dec_03_part_02(input)
  else
    raise ArgumentError.new "Part must be 1 or 2"
  end
end

def dec_03_part_01(input)
  # transpose it (so an array with the length being the number of columns)
  transp_input = transpose input

  # initialise
  gamma = ""
  epsilon = ""

  transp_input.each do |col|
    # produces sorted array: smallest first
    counts = col.split(//).tally.sort_by{ |k, v| v }
    # key name of largest value (i.e. most common out of 0 or 1)
    gamma << counts[1][0]
    # key name of smallest value (i.e. least common out of 0 or 1)
    epsilon << counts[0][0]
  end

  # convert to decimal and calculate power consumption
  gamma_i = gamma.to_i(2)
  epsilon_i = epsilon.to_i(2)
  power_consumption = gamma_i * epsilon_i

  puts "The gamma value is #{gamma} = #{gamma_i}"
  puts "The epsilon value is #{epsilon} = #{epsilon_i}"
  puts "Power consumption is #{power_consumption}"

  return power_consumption
end

def dec_03_part_02(input)
  co2 = get_rating(input, "co2")
  oxygen = get_rating(input, "oxygen")
  
  # convert to decimal and calculate power consumption
  oxygen_i = oxygen.to_i(2)
  co2_i = co2.to_i(2)
  life_support = oxygen_i * co2_i

  puts "The oxygen value is #{oxygen} = #{oxygen_i}"
  puts "The co2 value is #{co2} = #{co2_i}"
  puts "Life support is #{life_support}"

  return life_support
end

def transpose(input)
  len = input.map(&:length).max
  # needs to be a hash or all elements point to same object
  # meaning changing one element changes them all!
  output = Array.new(len) {""}

  input.each do |row|
    row.split(//).each_with_index { |v, i| output[i] << v}
  end

  return output
end

def extract_col(input, index)
  input.map { |item| item [index] }
end

def get_rating(input, rating)
  output = input.clone
  len = input.map(&:length).max
  i = 0

  while i < len && output.length > 1
    # Tally will look something like {"1" => 20, "0" => 35}
    tally = extract_col(output, i).tally
    if rating == "oxygen"
      # For oxygen, we want the MAX value
      # but the keys are sorted and reversed: since we want 1 to be chosen over 0
      # in the event of a tie
      bit = tally.filter { |k, v| v == tally.values.max }.keys.sort.reverse.first
    elsif rating == "co2"
      # For co2, we want the MIN value
      # but the keys are sorted ONLY: since we want 0 to be chosen over 1
      # in the event of a tie
      bit = tally.filter { |k, v| v == tally.values.min }.keys.sort.first
    else
      raise ArgumentError.new "rating must be 'oxygen' or 'co2'"
    end
    # remove items where the ith character is not the same as the chosen bit
    output.reject! { |item| item[i] != bit }
    # next column
    i += 1
  end

  # First just because output will be an array of length 1
  return output.first
end
