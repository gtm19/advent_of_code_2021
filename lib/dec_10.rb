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
  navg = Navigation.new(input: input)
  score = navg.incomplete_score
  puts "The incomplete error score is #{score}"
  return score
end
class Navigation
  attr_reader :lines

  BRACKETS = {
    "(" => {
      char: ")",
      corr_value: 3,
      inc_value: 1
    },
    "[" => {
      char: "]",
      corr_value: 57,
      inc_value: 2
    },
    "{" => {
      char: "}",
      corr_value: 1197,
      inc_value: 3
    },
    "<" => {
      char: ">",
      corr_value: 25137,
      inc_value: 4
    }
  }

  def initialize(args = {})
    @input = args[:input] || File.join("inputs", "test", "test_dec_10.txt")
    parse_input
  end

  def syntax_error_score
    scores = @lines.map do |line|
      check_line(line)
    end
    scores.select { |item| item[:status] == "corrupted" }.map{ |item| item[:score] }.sum
  end

  def incomplete_score
    scores = @lines.map do |line|
      check_line(line)
    end
    incomplete = scores.select { |item| item[:status] == "incomplete" }
    incomplete.sort_by { |item| item[:score] }[(incomplete.length - 1) / 2][:score]
  end
  
  def check_line(str_input)
    str_split = str_input.split //
    expected_closers = []
    output = {}
    str_split.each do |char|
      if BRACKETS.keys.map(&:to_s).include? char
        expected_closers << closer(char)[:char]
      else
        last_closer = expected_closers.pop
        unless last_closer.nil? || char == last_closer
          output[:valid] = false
          output[:status] = "corrupted"
          output[:expected] = last_closer
          output[:got] = char
          output[:score] = corr_score(char)
          break
        end
      end
    end

    if output[:valid].nil?
      output[:valid] = false
      output[:status] = "incomplete"
      output[:complete_with] = expected_closers.reverse.join
      output[:score] = completion_score(expected_closers.reverse)
    end

    output
  end

  private

  def closer(opener)
    BRACKETS[opener]
  end

  def corr_score(char)
    BRACKETS.select { |k, v| v[:char] == char }.values.first[:corr_value]
  end

  def completion_score(closers)
    score = 0
    closers.each do |closer|
      score = (score * 5) + BRACKETS.select { |k, v| v[:char] == closer }.values.first[:inc_value]
    end
    return score
  end

  def parse_input
    @lines = File.readlines(@input, chomp: true)
  end
end
