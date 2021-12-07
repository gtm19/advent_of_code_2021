require "dec_07"

TEST_INPUT_07 = File.join("inputs", "test", "test_dec_07.txt")

describe "December 07: Part 1" do
  it "should return the correct answer" do
    expect(dec_07(input = TEST_INPUT_07, part = 1)).to eq 37
  end
end

# describe "December 07: Part 2" do
#   it "should return the correct answer" do
#     expect(dec_07(input = TEST_INPUT_07, part = 2)).to eq 26984457539
#   end
# end
