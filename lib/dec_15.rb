def dec_15(input, part = 1)
  if part == 1
    dec_15_part_01(input)
  elsif part == 2
    dec_15_part_02(input)
  else
    raise ArgumentError.new "Part must be 1 or 2"
  end
end

def dec_15_part_01(input)
  risk_map = RiskMap.new(input: input)
end

def dec_15_part_02(input)

end

# So we implementing Dijkstra...
# this might help:
# https://isaaccomputerscience.org/concepts/dsa_search_dijkstra?examBoard=all&stage=all
class RiskMap
  attr_reader :nodes

  def initialize **args
    @input = args[:input] || File.join("inputs", "test", "test_dec_15.txt")
    parse_input
  end

  def adjacent(point = [])
    
  end

  private

  def parse_input
    lines = File.readlines(@input, chomp: true).map { |str| str.chars.map(&:to_i) }
    @nodes = {}
    lines.each_with_index do |row, row_n|
      row.each_with_index do |v, col_n|
        @nodes[[row_n, col_n]] = v
      end
    end
  end
end
