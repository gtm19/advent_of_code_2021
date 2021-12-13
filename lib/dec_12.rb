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

end

def dec_12_part_02(input)

end

class Cave
  attr_reader :name
  attr_accessor :adjacents, :visits

  def initialize(**args)
    @name = args[:name] || ArgumentError.new("oops")
    @visits = 0
    @adjacents = []
  end

  def add_adjacent(cave)
    unless @adjacents.include?(cave) # && cave.adjacents.include?(self)
      @adjacents << cave
      # cave.add_adjacent(self)
    end
  end

  def small?
    @name == @name.downcase
  end

  def big?
    !self.small?
  end

  def start?
    @name == "start"
  end

  def end?
    @name == "end"
  end

  def to_s
    @name
  end

  def useful?
    # is the cave:
    # the end?
    self.end? ||
    # OR big?
    self.big? ||
    # OR small AND not already visited AND adjacent to the end or a big cave
    self.small? && self.visits == 0 && self.adjacents.any? { |adj| adj.big? || adj.end? }  
  end

  def viable_adjacents
    return [] if end?
    @adjacents.select { |adjacent| adjacent.useful? }
  end
end

class CaveNetwork
  attr_accessor :caves
  attr_reader :routes

  def initialize(**args)
    @input = args[:input] || File.join("inputs", "test", "test_dec_12.txt")
    @caves = []
    initialize_caves
    trace_routes
  end

  def add_cave(name)
    if cave_names.include? name
      find_cave(name)
    else
      cave = Cave.new(name: name)
      @caves << cave
      cave
    end
  end

  def find_cave(name)
    @caves.select { |v| v.name == name }.first
  end

  def start
    find_cave("start")
  end

  def link_caves(name1, name2)
    find_cave(name1).add_adjacent(find_cave(name2))
  end

  def cave_names
    @caves.map(&:name)
  end

  def trace_routes
    full_routes = [[start]]
    complete = false
    until complete do
      full_routes.each do |route|
        last_cave = route.last
        unless last_cave.end?
          opts = last_cave.viable_adjacents
          new_routes = []
          opts.each do |opt|
            opt.visits += 1
            new_routes << route + [opt]
          end
          route = new_routes
        end
      end
      binding.pry
      full_routes.flatten!
      complete = full_routes.all? { |r| r.end? }
    end
    @routes = full_routes
  end

  private

  def initialize_caves
    if @input
      File.readlines(@input, chomp: true).each do |link|
        caves = link.split("-").map{ |name| add_cave(name) }
        caves[0].add_adjacent caves[1]
        caves[1].add_adjacent caves[0]
      end
    end
  end
end
