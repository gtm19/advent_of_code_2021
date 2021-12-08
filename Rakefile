require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task default: %w[rubocop spec]

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

# Initialise new files
task :init, [:stub] do |_t, args|
  stub = args.stub
  stub_num = stub.match(/\d+/).to_s
  puts "Initialising #{stub} files"
  sh "touch inputs/#{stub}.txt inputs/test/test_#{stub}.txt"

  # Spec file
  spec_file = File.join("spec", "#{stub}_spec.rb")
  spec_text = <<~EOF
    require "#{stub}"

    TEST_INPUT_#{stub_num} = File.join("inputs", "test", "test_#{stub}.txt")

    describe "December #{stub_num}: Part 1" do
      it "should return the correct answer" do
        expect(#{stub}(input = TEST_INPUT_#{stub_num}, part = 1)).to eq "REPLACE_ME"
      end
    end

    describe "December #{stub_num}: Part 2" do
      it "should return the correct answer" do
        expect(#{stub}(input = TEST_INPUT_#{stub_num}, part = 2)).to eq "REPLACE_ME"
      end
    end
  EOF
  File.write(spec_file, spec_text)

  # Lib file
  lib_file = File.join("lib", "#{stub}.rb")
  lib_text = <<~EOF
    def #{stub}(input, part = 1)
      if part == 1
        #{stub}_part_01(input)
      elsif part == 2
        #{stub}_part_02(input)
      else
        raise ArgumentError.new "Part must be 1 or 2"
      end
    end

    def #{stub}_part_01(input)

    end

    def #{stub}_part_02(input)

    end
  EOF
  File.write(lib_file, lib_text)
end

def run(task)
  input = yield
  puts "Part 1:"
  puts "---------"
  send(task, input, part = 1)
  puts "---------"
  puts "Part 2:"
  puts "---------"
  send(task, input, part = 2)
  puts "---------"
end

task :dec_01 do |task|
  run(task.name) { File.readlines("inputs/#{task.name}.txt", chomp: true).map(&:to_i) }
end

task :dec_02 do |task|
  run(task.name) { File.readlines("inputs/#{task.name}.txt", chomp: true) }
end

task :dec_03 do |task|
  run(task.name) { File.readlines("inputs/#{task.name}.txt", chomp: true).filter { |item| item.length > 1} }
end

task :dec_04 do |task|
  run(task.name) { File.join(__dir__, "inputs", "#{task.name}.txt") }
end

task :dec_05 do |task|
  run(task.name) { File.join(__dir__, "inputs", "#{task.name}.txt") }
end

task :dec_06 do |task|
  run(task.name) { File.join(__dir__, "inputs", "#{task.name}.txt") }
end

task :dec_07 do |task|
  run(task.name) { File.join(__dir__, "inputs", "#{task.name}.txt") }
end

task :dec_08 do |task|
  run(task.name) { File.join(__dir__, "inputs", "#{task.name}.txt") }
end

task :lab do |t|
  p t.name
end
