require "dec_01"

TEST_INPUT_01 = [
  199,
  200,
  208,
  210,
  200,
  207,
  240,
  269,
  260,
  263
]

describe "December 01: Part 1" do
  it "should return the correct answer" do
    expect(dec_01(input = TEST_INPUT_01)).to eq 7
  end
end

describe "December 01: Part 2" do
  it "should return the correct answer" do
    expect(dec_01(input = TEST_INPUT_01, window = 3)).to eq 5
  end
end
