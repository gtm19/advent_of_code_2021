require "dec_15"

TEST_INPUT_15 = File.join("inputs", "test", "test_dec_15.txt")

describe "December 15: Part 1" do
  it "should return the correct answer" do
    expect(dec_15(input = TEST_INPUT_15, part = 1)).to eq 40
  end
end

describe "December 15: Part 2" do
  it "should return the correct answer" do
    expect(dec_15(input = TEST_INPUT_15, part = 2)).to eq 315
  end
end
