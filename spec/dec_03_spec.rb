require "dec_03"

TEST_INPUT_03 = [
  "forward 5",
  "down 5",
  "forward 8",
  "up 3",
  "down 8",
  "forward 2"
]

describe "December 03: Part 1" do
  it "should return the correct answer" do
    expect(dec_03(input = TEST_INPUT_03)).to eq 150
  end
end

# describe "Part 2" do
#   it "should return the correct answer" do
#     expect(dec_03(input = TEST_INPUT_03)).to eq nil
#   end
# end
