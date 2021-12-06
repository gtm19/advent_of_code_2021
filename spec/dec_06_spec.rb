require "dec_06"

TEST_INPUT_06 = File.join("inputs", "test", "test_dec_06.txt")

describe "December 06: Part 1" do
  it "should return the correct answer" do
    expect(dec_06(input = TEST_INPUT_04, part = 1)).to eq 5934
  end
end

# describe "December 06: Part 2" do
#   it "should return the correct answer" do
#     expect(dec_06(input = TEST_INPUT_04, part = 2)).to eq 1924
#   end
# end
