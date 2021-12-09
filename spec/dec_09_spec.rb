require "dec_09"

TEST_INPUT_09 = File.join("inputs", "test", "test_dec_09.txt")

describe "December 09: Part 1" do
  it "should return the correct answer" do
    expect(dec_09(input = TEST_INPUT_09, part = 1)).to eq 15
  end
end

describe "December 09: Part 2" do
  it "should return the correct answer" do
    expect(dec_09(input = TEST_INPUT_09, part = 2)).to eq 1134
  end
end
