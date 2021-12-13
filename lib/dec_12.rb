require "pry-byebug"

def dec_12(input, part = 1)
  if part == 1
    dec_12_part_01(input)
  elsif part == 2
    dec_12_part_02(input)
  else
    raise ArgumentError.new "Part must be 1 or 2"
  end
end

def dec_12_part_01(input)
  cave_network = CaveNetwork.new(input: input)
  cave_network.trace_routes
  routes_n = cave_network.routes.length
  puts "There are #{routes_n} valid route(s) through the caves"
  return routes_n
end

def dec_12_part_02(input)
  cave_network = CaveNetwork.new(input: input)
  # need to trace routes once for each "special" cave
  # i.e. everything other than :start and :end
  cave_network.caves.keys.reject { |k| [:start, :end].include?(k) }.each do |node|
    cave_network.trace_routes(:start, :end, node)
  end
  routes_n = cave_network.routes.uniq.length
  puts "There are #{routes_n} valid route(s) through the caves"
  return routes_n
end

class CaveNetwork
  attr_accessor :caves
  attr_reader :routes

  def initialize(**args)
    @input = args[:input] || File.join("inputs", "test", "test_dec_12.txt")
    @caves = {}
    @routes = []
    initialize_caves
  end

  # I have no shame in confessing that I initially created a very complicated
  # potential solution which was very difficult to work through, so I found
  # the following example, which was very instructive
  # https://gist.github.com/kaine119/8bec5cbe2d97868da16a84744e5b7e38
  def trace_routes(current = :start, last = :end, special = nil, visited = [])
    # if current cave is the targeted last cave, then add it to visited
    # and we have ourselves a complete route. Add it to @routes and 
    # return so that the method exits
    return @routes << visited + [last] if current == last
    # if we don't exit above...
    # for each cave linked to our current cave
    @caves[current].each do |cave|
      # skip if we've already visited or it's a small cave
      if visited.include?(cave) && cave.downcase == cave
        # UNLESS it's our special cave which we are visiting for a second time
        next unless cave == special && visited.count(cave) == 1
      end
      # trace routes, this time from the current cave, adding the same
      # to our visited caves
      trace_routes(cave, last, special = special, visited + [current])
    end
  end

  private

  def initialize_caves
    if @input
      File.readlines(@input, chomp: true).each do |link|
        # new caves looks like [:one, :two]
        new_caves = link.split("-").map(&:to_sym)
        # initialise @caves[:one] = [] unless it already exists
        @caves[new_caves[0]] ||= []
        # add [:two] to @caves[:one]
        @caves[new_caves[0]] << new_caves[1]
        # AND VICE VERSA
        @caves[new_caves[1]] ||= []
        @caves[new_caves[1]] << new_caves[0]
      end
    end
  end
end
