require "dec_02"

TEST_INPUT_02 = [
  "forward 5",
  "down 5",
  "forward 8",
  "up 3",
  "down 8",
  "forward 2"
]

describe "Part 1" do
  it "should return the correct answer" do
    expect(dec_02(input = TEST_INPUT_02)).to eq 150
  end
end

# describe "Part 2" do
#   it "should return the correct answer" do
#     expect(dec_01(input = TEST_INPUT_01, window = 3)).to eq 5
#   end
# end