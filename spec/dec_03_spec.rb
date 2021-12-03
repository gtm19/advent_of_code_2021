require "dec_03"

TEST_INPUT_03 = [
  "00100",
  "11110",
  "10110",
  "10111",
  "10101",
  "01111",
  "00111",
  "11100",
  "10000",
  "11001",
  "00010",
  "01010"
]

describe "December 03: Part 1" do
  it "should return the correct answer" do
    expect(dec_03(input = TEST_INPUT_03)).to eq 198
  end
end

# describe "Part 2" do
#   it "should return the correct answer" do
#     expect(dec_03(input = TEST_INPUT_03)).to eq nil
#   end
# end
