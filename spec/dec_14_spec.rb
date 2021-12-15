require "dec_14"

TEST_INPUT_14 = File.join("inputs", "test", "test_dec_14.txt")

describe "December 14: Part 1" do
  it "should return the correct answer" do
    expect(dec_14(input = TEST_INPUT_14, part = 1)).to eq 1588
  end
end

describe "December 14: Part 2" do
  it "should return the correct answer" do
    expect(dec_14(input = TEST_INPUT_14, part = 2)).to eq "REPLACE_ME"
  end
end
