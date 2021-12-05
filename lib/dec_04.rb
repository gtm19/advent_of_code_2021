require "pry-byebug"

def dec_04(input, part)
  if part == 1
    dec_04_part_01(input)
  elsif part == 2
    dec_04_part_02(input)
  else
    raise ArgumentError.new "Part must be 1 or 2"
  end
end

def dec_04_part_01(input)
  game = Game.new(input: input)
  game.run_game
  if game.solutions.any?
    solution = game.solutions.first
    puts "Success! Card #{solution[:card_index]} is the winner"
    puts "With a score of #{solution[:score]}"
    return solution[:score]
  end
end

def dec_04_part_02(input)
  game = Game.new(input: input)
  game.run_game
  if game.solutions.any?
    solution = game.solutions.last
    puts "Oh no! Card #{solution[:card_index]} is the loser"
    puts "With a score of #{solution[:score]}"
    return solution[:score]
  end
end

class Game
  attr_reader :numbers, :cards, :solutions

  def initialize(args = {})
    @input = args[:input]
    @solutions = []
    extract_data
  end

  def read_file
    File.readlines(@input, chomp: true)
  end

  def extract_data
    lines = read_file
    @numbers = lines.slice(0).split(/\D/).map(&:to_i)
    lines.slice!(0..1)
    @cards = lines.chunk { |item| item.length > 0 }
      .filter { |test, v| test }
      .map { |test, v| v.map { |item| item.split.map(&:to_i) } }
  end

  def run_game
    # Somewhere to tick off cards which have "won"
    winning_cards = Hash.new
    n = 4
    # for @numbers 0...n and where all cards have not already won
    while n < @numbers.length && winning_cards.length < numbers.length do
      # Get the numbers drawn to date
      numbers_so_far = @numbers[0..n]
      # for each card
      @cards.each_with_index do |card, index|
        # get the score given numbers_so_far (if the card is a winner)
        score = check_numbers(card, numbers_so_far)
        # if a score was returned
        if score
          # make a hash with the card concerned and its score
          solution = {
            card_index: index,
            score: score
          }
          # add it to the solutions unless this card has already won
          @solutions << solution unless winning_cards[index.to_s]
          # mark this card as a winner
          winning_cards[index.to_s] ||= true
        end
      end
      # draw another number and go again!
      n += 1
    end
  end

  def check_numbers(card, numbers)
    # create an array with both rows and columns of the cards in it
    rows_and_cols = card.clone.concat(card.transpose)
    # grab the last number drawn as we only want to return winning
    # rows / columns from the most recent number drawn
    last_number = numbers[-1]
    matches = rows_and_cols.filter do |item|
      # get all rows/columns whose length matches the number of 
      # matches with the drawn number, but where the row/column
      # also includes the most recently drawn ball
      item.intersection(numbers).length == item.length && item.include?(last_number)
    end
    # Get the unmarked numbers from the card: those which do not
    # appear in the numbers drawn
    unmarked = card.flatten.filter { |item| !numbers.include?(item) }
    if matches.first && unmarked.any? # if there is match and there are some unmarked numbers
      # calculate and return the score
      score = unmarked.reduce(&:+) * last_number
      return score
    end
  end
end