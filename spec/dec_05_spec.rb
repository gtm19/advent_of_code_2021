require "dec_05"

TEST_INPUT_05 = File.join("inputs", "test", "test_dec_05.txt")

describe "December 05: Part 1" do
  it "should return the correct answer" do
    expect(dec_05(input = TEST_INPUT_05, part = 1)).to eq 5
  end
end

describe "December 05: Part 2" do
  it "should return the correct answer" do
    expect(dec_05(input = TEST_INPUT_05, part = 2)).to eq 12
  end
end

describe "December 05: Utils | create_seq" do
  it "increasing sequence should work" do
    expect(create_seq(1, 10)).to eq (1..10).to_a
  end

  it "decreasing sequence should work" do
    expect(create_seq(10, 1)).to eq (1..10).to_a.reverse
  end

  it "sequence of size 1 should work" do
    expect(create_seq(10, 10)).to eq [10]
  end
end

describe "December 05: Utils | diag tests" do
  it "increasing sequence should work" do
    expect(diag([[0, 0], [8, 8]])).to eq true
  end

  it "decreasing sequence should work" do
    expect(diag([[8, 8], [0, 0]])).to eq true
  end


  it "offset decreasing sequence should work" do
    expect(diag([[6, 4], [2, 0]])).to eq true
  end
end

describe "December 05: Utils | interpolate_coords" do
  it "same row (increasing) should work" do
    expect(interpolate_coords([[1,4], [1,7]])).to eq [[1,4], [1,5], [1, 6], [1,7]]
  end

  it "same row (decreasing) should work" do
    expect(interpolate_coords([[1,7], [1,4]])).to eq [[1,4], [1,5], [1, 6], [1,7]].reverse
  end

  it "same col (increasing) should work" do
    expect(interpolate_coords([[1,7], [4,7]])).to eq [[4, 7], [3, 7], [2, 7], [1, 7]].reverse
  end

  it "same col (decreasing) should work" do
    expect(interpolate_coords([[4,7], [1,7]])).to eq [[4, 7], [3, 7], [2, 7], [1, 7]]
  end

  it "diagonal (45 deg) increasing should work" do
    expect(interpolate_coords([[1,1], [3,3]])).to eq [[1, 1], [2, 2], [3, 3]]
  end

  it "diagonal (45 deg) decreasing should work" do
    expect(interpolate_coords([[3,3], [1,1]])).to eq [[1, 1], [2, 2], [3, 3]].reverse
  end

  it "diagonal (135 deg) increasing should work" do
    expect(interpolate_coords([[1,4], [4,1]])).to eq [[1, 4], [2, 3], [3, 2], [4, 1]]
  end

  it "diagonal (135 deg) decreasing should work" do
    expect(interpolate_coords([[4,1], [1,4]])).to eq [[1, 4], [2, 3], [3, 2], [4, 1]].reverse
  end
end
