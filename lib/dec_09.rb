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
  height_map = HeightMap.new(input: input)
  risk_level = height_map.basin_risk_level
  puts "This height map has #{height_map.basins.length} basins"
  puts "and a basin risk level of #{risk_level}"
  return risk_level
end

class HeightMap
  attr_reader :heights, :low_points, :basins

  def initialize(args = {})
    @input = args[:input] || File.join("inputs", "test", "test_dec_09.txt")
    parse_input
    get_low_points
    get_basins
  end

  def get_height(col_n, row_n)
    return nil if col_n.negative? || row_n.negative?
    row = @heights[row_n]
    if row && row[col_n]
      {
        pos: [col_n, row_n],
        height: row[col_n]
      }
    end
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
        adj_heights = get_adjacent_heights(col_n, row_n).map { |v| v[:height] }.compact
        point = {
          pos: [col_n, row_n],
          height: row[col_n]
        }
        low_test = adj_heights.all? { |h| h > point[:height] }
        (@low_points << point) if low_test
      end
    end
  end

  def get_basins
    @basins = @low_points.map do |point|
      basin = [point]
      basin.each do |basin_point|
        adj_points = get_adjacent_heights(*basin_point[:pos])
        adj_points.each do |point|
          basin << point if !basin.include?(point) && point[:height] < 9 && point[:height] > basin_point[:height]
        end
      end
      basin
    end
  end

  def risk_level
    @low_points.map { |v| v[:height] }.sum + @low_points.length
  end

  def basin_risk_level
    basins = @basins.sort_by(&:length).reverse.take(3)
    basins.map(&:length).reduce(&:*)
  end

  private

  def parse_input
    @heights = File.readlines(@input, chomp: true).map { |line| line.split(//).map(&:to_i) }
  end

end
