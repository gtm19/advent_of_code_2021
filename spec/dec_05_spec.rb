require "dec_05"

TEST_INPUT_05 = File.join("inputs", "test", "test_dec_05.txt")

describe "December 05: Part 1" do
  it "should return the correct answer" do
    expect(dec_05(input = TEST_INPUT_05, part = 1)).to eq 5
  end
end

# describe "December 05: Part 2" do
#   it "should return the correct answer" do
#     expect(dec_05(input = TEST_INPUT_05, part = 2)).to eq 1924
#   end
# end
