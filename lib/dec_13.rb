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

end

def dec_13_part_02(input)

end

class FoldingPaper
  attr_reader :dots, :folds

  def initialize(**args)
    @input = args[:input] || File.join("inputs", "test", "test_dec_13.txt")
    parse_input
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
