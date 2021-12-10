def dec_10(input, part = 1)
  if part == 1
    dec_10_part_01(input)
  elsif part == 2
    dec_10_part_02(input)
  else
    raise ArgumentError.new "Part must be 1 or 2"
  end
end

def dec_10_part_01(input)
  navg = Navigation.new(input: input)
  score = navg.syntax_error_score
  puts "The syntax error score is #{score}"
  return score
end

def dec_10_part_02(input)

end
class Navigation
  attr_reader :lines

  BRACKETS = {
    "(": {
      char: ")",
      value: 3
    },
    "[": {
      char: "]",
      value: 57
    },
    "{": {
      char: "}",
      value: 1197
    },
    "<": {
      char: ">",
      value: 25137
    }
  }

  def initialize(args = {})
    @input = args[:input] || File.join("inputs", "test", "test_dec_10.txt")
    parse_input
  end

  def syntax_error_score
    scores = @lines.map do |line|
      check = check_line(line)
      check[:score] || 0
    end
    scores.sum
  end

  
  def check_line(str_input)
    str_split = str_input.split //
    expected_closers = []
    output = {valid: true}
    str_split.each do |char|
      if BRACKETS.keys.map(&:to_s).include? char
        expected_closers << closer(char)[:char]
      else
        last_closer = expected_closers.pop
        unless last_closer.nil? || char == last_closer
          output[:valid] = false
          output[:expected] = last_closer
          output[:got] = char
          output[:score] = closer_score(char)
          break
        end
      end
    end
    output
  end

  private

  def closer(opener)
    BRACKETS[opener.to_sym]
  end

  def closer_score(char)
    BRACKETS.select { |k, v| v[:char] == char }.values.first[:value]
  end

  def parse_input
    @lines = File.readlines(@input, chomp: true)
  end
end

# DANGER ZONE
