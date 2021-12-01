require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require_relative "lib/dec_01"

task :dec_01 do
  input = File.readlines("inputs/dec_01.txt", chomp: true).map(&:to_i)
  dec_01(input)
  dec_01(input, window = 3)
end

task default: %w[spec]
