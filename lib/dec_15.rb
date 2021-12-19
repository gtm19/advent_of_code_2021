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
  risk_map.setup
  risk_map.dijkstra
  risk_score = risk_map.distances[risk_map.distances.keys.max][:d]
  puts "The risk score to get to point #{risk_map.distances.keys.max} is #{risk_score}"
  return risk_score
end

def dec_15_part_02(input)
  risk_map = RiskMap.new(input: input)
  risk_map.expand
  risk_map.setup
  risk_map.dijkstra
  risk_score = risk_map.distances[risk_map.distances.keys.max][:d]
  puts "The risk score to get to point #{risk_map.distances.keys.max} is #{risk_score}"
  return risk_score
end

# So we implementing Dijkstra...
# this might help:
# https://isaaccomputerscience.org/concepts/dsa_search_dijkstra?examBoard=all&stage=all
class RiskMap
  attr_reader :nodes, :unvisited, :distances

  def initialize **args
    @input = args[:input] || File.join("inputs", "test", "test_dec_15.txt")
    parse_input
  end

  def nearest_unvisited
    distance_keys = @distances.select { |k, v| v[:d] < Float::INFINITY }.keys
    @distances.slice(*(distance_keys & @unvisited.keys)).min_by { |k, v| v[:d] }
  end

  def adjacent_all(point = [])
    nearby_points = [[-1, 0], [1, 0], [0, 1], [0, -1]].map { |offset| [point, offset].transpose.map(&:sum) }
    @nodes.select { |k, v| nearby_points.include?(k) }
  end

  def see_distances
    @distances.sort_by { |k, v| k}.each { |k, v| puts "#{k}: #{v}" }
  end

  def dijkstra(current = [0, 0], d = 0)
    count = 0
    @distances[current][:d] = d
    while @unvisited.keys.include?(@nodes.keys.max)
      count += 1
      if count % 100 == 0
        print "Visited #{count} nodes in #{Time.now.inspect}\r"
      end
      node = nearest_unvisited
      @unvisited.delete(node[0])
      neighbours = adjacent_all(node[0])
      neighbours.each do |neighbour|
        alt = node[1][:d] + neighbour[1]
        if alt < @distances[neighbour[0]][:d]
          @distances[neighbour[0]][:d] = alt
          @distances[neighbour[0]][:last] = node[0]
        end
      end
    end
  end

  def setup
    @unvisited = nodes.clone
    @distances = {}
    @nodes.each do |k, v|
      distances[k] = {d: Float::INFINITY, last: nil}
    end
  end

  def expand
    seq = (0..40).step(10).to_a
    offsets = seq.product(seq)
    nodes = @nodes.clone
    offsets.each do |offset|
      nodes.each do |k, v|
        new_node = [k, offset].transpose.map(&:sum)
        new_val = 1 + ((v + (offset.sum / 10) - 1) % 9)
        @nodes[new_node] = new_val
      end
    end
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
