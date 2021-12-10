require "dec_10"

TEST_INPUT_10 = File.join("inputs", "test", "test_dec_10.txt")

describe "December 10: Part 1" do
  it "should return the correct answer" do
    expect(dec_10(input = TEST_INPUT_10, part = 1)).to eq 26397
  end
end

describe "December 10: Part 2" do
  it "should return the correct answer" do
    expect(dec_10(input = TEST_INPUT_10, part = 2)).to eq "REPLACE_ME"
  end
end
