require "dec_04"

TEST_INPUT_04 = File.join("inputs", "test", "test_dec_04.txt")

describe "December 04: Part 1" do
  it "should return the correct answer" do
    expect(dec_04(input = TEST_INPUT_04, part = 1)).to eq 4512
  end
end

describe "December 04: Part 2" do
  it "should return the correct answer" do
    expect(dec_04(input = TEST_INPUT_04, part = 2)).to eq 1924
  end
end
