require "dec_11"

TEST_INPUT_11 = File.join("inputs", "test", "test_dec_11.txt")

describe "December 11: Part 1" do
  it "should return the correct answer" do
    expect(dec_11(input = TEST_INPUT_11, part = 1)).to eq 1656
  end
end

describe "December 11: Part 2" do
  it "should return the correct answer" do
    expect(dec_11(input = TEST_INPUT_11, part = 2)).to eq "REPLACE_ME"
  end
end
