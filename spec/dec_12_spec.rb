require "dec_12"

TEST_INPUT_12 = File.join("inputs", "test", "test_dec_12.txt")

describe "December 12: Part 1" do
  it "should return the correct answer" do
    expect(dec_12(input = TEST_INPUT_12, part = 1)).to eq 19
  end
end

describe "December 12: Part 2" do
  it "should return the correct answer" do
    expect(dec_12(input = TEST_INPUT_12, part = 2)).to eq 103
  end
end
