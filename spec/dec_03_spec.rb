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
    expect(dec_03(input = TEST_INPUT_03, part = 1)).to eq 198
  end
end

describe "December 03: Part 2" do
  it "should return the correct answer" do
    expect(dec_03(input = TEST_INPUT_03, part = 2)).to eq 230
  end
end
