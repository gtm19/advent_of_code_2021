require "dec_13"

TEST_INPUT_13 = File.join("inputs", "test", "test_dec_13.txt")

describe "December 13: Part 1" do
  it "should return the correct answer" do
    expect(dec_13(input = TEST_INPUT_13, part = 1)).to eq 17
  end
end
