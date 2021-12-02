require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

# Require all files from lib directory
Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }

task :dec_01 do
  input = File.readlines("inputs/dec_01.txt", chomp: true).map(&:to_i)
  puts "Part 1:"
  puts "---------"
  dec_01(input)
  puts "---------"
  puts "Part 2:"
  puts "---------"
  dec_01(input, window = 3)
  puts "---------"
end

task :dec_02 do
  input = File.readlines("inputs/dec_02.txt", chomp: true)
  puts "Part 1:"
  puts "---------"
  dec_02(input)
  puts "---------"
  puts "Part 2:"
  puts "---------"
  dec_02(input, journey_class = JourneyV2)
  puts "---------"
end

task default: %w[spec]
