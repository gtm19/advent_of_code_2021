def dec_13(input, part = 1)
  if part == 1
    dec_13_part_01(input)
  elsif part == 2
    dec_13_part_02(input)
  else
    raise ArgumentError.new "Part must be 1 or 2"
  end
end

def dec_13_part_01(input)
  paper = FoldingPaper.new(input: input)
  paper.fold
  n_dots = paper.dots.length
  puts "There are #{n_dots} after 1 fold"
  return n_dots
end

def dec_13_part_02(input)
  paper = FoldingPaper.new(input: input)
  paper.folds.length.times { paper.fold }
  puts paper
end

class FoldingPaper
  attr_reader :dots, :folds

  def initialize(**args)
    @input = args[:input] || File.join("inputs", "test", "test_dec_13.txt")
    parse_input
  end

  def fold
    fold = @folds.shift
    crease = fold.values.first
    index = fold[:x] ? 0 : 1
    @dots.each do |dot|
      dot[index] = 2 * crease - dot[index] if dot[index] > crease
    end
    @dots.uniq!
  end

  def to_s
    rows = @dots.map { |dot| dot[0] }.max + 1
    cols = @dots.map { |dot| dot[1] }.max + 1

    array = Array.new(rows) { Array.new(cols) {" "} }

    @dots.each do |dot|
      array[dot[0]][dot[1]] = "▉"
    end

    array.transpose.map(&:join).join("\n")
  end

  private

  def parse_input
    dots, folds = File.readlines(@input, chomp: true).reject(&:empty?).partition { |line| line.match(/\d+,\d+/) }
    # dots
    dots.map! { |coords| coords.split(",").map(&:to_i) }
    @dots = dots

    # folds
    @folds = []
    folds.each do |fold|
      matches = fold.match(/(?<dir>x|y)=(?<loc>\d+)$/)
      @folds << {
        matches[:dir].to_sym => matches[:loc].to_i
      }
    end
  end
end
