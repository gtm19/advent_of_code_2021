def dec_03(input)
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
