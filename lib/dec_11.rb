def dec_11(input, part = 1)
  if part == 1
    dec_11_part_01(input)
  elsif part == 2
    dec_11_part_02(input)
  else
    raise ArgumentError.new "Part must be 1 or 2"
  end
end

def dec_11_part_01(input)
  octo = Octopi.new(input: input)
  steps = 100
  steps.times { octo.step }
  puts "After #{steps} steps, there have been #{octo.flashes} flashes"
  return octo.flashes
end

def dec_11_part_02(input)
  octo = Octopi.new(input: input)
  octo.synchronise
  puts "After #{octo.steps} steps, all octopi are synchronised"
  return octo.steps
end

class Octopi
  attr_reader :positions, :flashes, :steps

  def initialize(**args)
    @input = args[:input] || File.join("inputs", "test", "test_dec_11.txt")
    parse_input
    @flashes = 0
    @steps = 0
  end

  def step
    new_flashers = []
    @positions.each_with_index do |row, row_n|
      row.map!.with_index do |item, col_n|
        # add one to each energy level
        item += 1
        # add all with energy level > 9 to array of flashers
        new_flashers << {row: row_n, col: col_n} if item == 10
        item
      end
    end
    # get all adjacent positions to new flashers
    new_flashers.each do |flasher|
      adj_points = get_adj(flasher)
      adj_points.each do |point|
        # add one to each of these adjacent positions
        item = @positions[point[:row]][point[:col]] += 1
        # get new flashers, add them to array of flashers
        new_flashers << {row: point[:row], col: point[:col]} if item == 10
      end
    end

    # increase number of flashes
    @flashes += new_flashers.length

    # set all flashed octopi to zero
    new_flashers.each do |point|
      @positions[point[:row]][point[:col]] = 0
    end

    # add 1 to steps
    @steps += 1

    return true
  end
  
  def synchronise
    synchronised = false
    until synchronised
      step
      synchronised = all_zero?
    end
  end
  
  private
  
  def get_adj(pos, max = 10)
    adj_points = [
      [-1, -1],
      [-1,  0],
      [-1,  1],
      [0 , -1],
      [0 ,  1],
      [1 , -1],
      [1 ,  0],
      [1 ,  1]
    ].map do |offset|
      new_row = pos[:row] + offset[0]
      new_col = pos[:col] + offset[1]
      {
        row: pos[:row] + offset[0],
        col: pos[:col] + offset[1]
      } if new_row >= 0 && new_col >= 0 && new_row < max && new_col < max
    end

    adj_points.compact
  end

  def parse_input
    @positions = File.readlines(@input, chomp: true).map do |row|
      row.split(//).map(&:to_i)
    end
  end

  def all_zero?
    @positions.all? do |row|
      row.all?(&:zero?)
    end
  end
end