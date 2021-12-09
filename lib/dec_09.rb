def dec_09(input, part = 1)
  if part == 1
    dec_09_part_01(input)
  elsif part == 2
    dec_09_part_02(input)
  else
    raise ArgumentError.new "Part must be 1 or 2"
  end
end

def dec_09_part_01(input)
  height_map = HeightMap.new(input: input)
  risk_level = height_map.risk_level
  puts "This height map has #{height_map.low_points.length} low points"
  puts "and a risk level of #{risk_level}"
  return risk_level
end

def dec_09_part_02(input)

end

class HeightMap
  attr_reader :heights, :low_points

  def initialize(args = {})
    @input = args[:input] || File.join("inputs", "test", "test_dec_09.txt")
    parse_input
    get_low_points
  end

  def get_height(col_n, row_n)
    return nil if col_n.negative? || row_n.negative?
    row = @heights[row_n]
    row[col_n] if row
  end

  def get_adjacent_heights(col_n, row_n)
    points = [
      [col_n, row_n - 1],
      [col_n, row_n + 1],
      [col_n - 1, row_n],
      [col_n + 1, row_n]
    ]

    points.map { |point| get_height(point[0], point[1]) }.compact
  end

  def get_low_points
    @low_points = []
    for row_n in 0...@heights.length do
      row = @heights[row_n]
      for col_n in 0...row.length do
        adj_heights = get_adjacent_heights(col_n, row_n)
        height = row[col_n]
        low_test = adj_heights.all? { |h| h > height }
        (@low_points << [col_n, row_n]) if low_test
      end
    end
  end

  def risk_level
    @low_points.map { |v| get_height(v[0], v[1]) }.sum + @low_points.length
  end

  private

  def parse_input
    @heights = File.readlines(@input, chomp: true).map { |line| line.split(//).map(&:to_i) }
  end

end
