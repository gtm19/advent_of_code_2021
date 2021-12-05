def dec_05(input, part = 1)
  if part == 1
    dec_05_part_01(input)
  elsif part == 2
    dec_05_part_02(input)
  else
    raise ArgumentError.new "Part must be 1 or 2"
  end
end

def dec_05_part_01(input)
  floor = parse_floor(input)
  straight_floor = floor.filter { |item| same_row(item) || same_col(item) }
  all_points = straight_floor.map do |points|
    interpolate_coords(points)
  end
  count = all_points.flatten(1).tally.values.count { |x| x > 1 }
  puts "There are #{count} points which appear at least twice on the floor"
  count
end

def dec_05_part_02(input)
  floor = parse_floor(input)
  straight_floor = floor.filter do |item|
    same_row(item) || same_col(item) || diag(item)
  end
  all_points = straight_floor.map do |points|
    interpolate_coords(points)
  end
  count = all_points.flatten(1).tally.values.count { |x| x > 1 }
  puts "There are #{count} points which appear at least twice on the floor"
  count
end

def parse_floor(input)
  lines = File.readlines(input)
  lines.map do |item|
    item.split(/[^\d,]+/).map do |coords|
      coords.split(/\D/).map(&:to_i)
    end
  end
end

def interpolate_coords(coords)
  x = create_seq(coords[0][0], coords[1][0])
  y = create_seq(coords[0][1], coords[1][1])
  if x.length == y.length
    return x.zip(y)
  end
  x.product(y).uniq
end

def create_seq(from, to)
  from.step(to, from <= to ? 1 : -1).to_a
end

def same_row(coords)
  coords[0][0] == coords[1][0]
end

def same_col(coords)
  coords[0][1] == coords[1][1]
end

def diag(coords)
  x_diff = coords[0][0] - coords[1][0]
  y_diff = coords[0][1] - coords[1][1]

  x_diff.abs == y_diff.abs
end