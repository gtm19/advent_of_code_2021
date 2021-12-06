require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

# Require all files from lib directory
Dir[File.join(__dir__, 'lib', '*.rb')].sort.each { |file| require file }

# rubocop
desc "Look for style guide offenses in your code"
task :rubocop do
  sh "rubocop --format simple || true"
end

# create irb with lib loaded
desc "Create an interactive console with all lib files loaded"
task :console do
  files = Dir[File.join(__dir__, 'lib', '*.rb')].sort
  require_command = files.map { |file| '-r ' + file }.join(" ")
  sh "irb -f #{require_command}"
end


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

task :dec_03 do
  input = File.readlines("inputs/dec_03.txt", chomp: true).filter { |item| item.length > 1}
  puts "Part 1:"
  puts "---------"
  dec_03(input)
  puts "---------"
  puts "Part 2:"
  puts "---------"
  dec_03(input, part = 2)
  puts "---------"
end

task :dec_04 do
  input = File.join(__dir__, "inputs", "dec_04.txt")
  puts "Part 1:"
  puts "---------"
  dec_04(input, part = 1)
  puts "---------"
  puts "Part 2:"
  puts "---------"
  dec_04(input, part = 2)
  puts "---------"
end

task :dec_05 do
  input = File.join(__dir__, "inputs", "dec_05.txt")
  puts "Part 1:"
  puts "---------"
  dec_05(input, part = 1)
  puts "---------"
  puts "Part 2:"
  puts "---------"
  dec_05(input, part = 2)
  puts "---------"
end

task :dec_06 do
  input = File.join(__dir__, "inputs", "dec_06.txt")
  puts "Part 1:"
  puts "---------"
  dec_06(input, part = 1)
  puts "---------"
  puts "Part 2:"
  puts "---------"
  # dec_05(input, part = 2)
  puts "---------"
end

task default: %w[rubocop spec]
