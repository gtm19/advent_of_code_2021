require "dec_08"

TEST_INPUT_08 = File.join("inputs", "test", "test_dec_08.txt")

describe "December 08: Part 1" do
  it "should return the correct answer" do
    expect(dec_08(input = TEST_INPUT_08, part = 1)).to eq 26
  end
end

describe "December 08: Part 2" do
  it "should return the correct answer" do
    expect(dec_08(input = TEST_INPUT_08, part = 2)).to eq 61229
  end
end
