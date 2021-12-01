def dec_01(input, window = 1)
  # Initialise empty "window" message
  window_msg = ""
  if window > 1 && window.is_a?(Integer)
    # Calculate rolling sum of input
    input = input.each_cons(window).map(&:sum)
    # Add the window size to the window message
    window_msg = ", with sliding window of size #{window}"
  end

  # Count the number of times successive elements of the array increase
  n_increases = input.each_cons(2).count { |a, b| b - a > 0 }
  puts "There are #{n_increases} increases that are larger than the previous input" + window_msg
  # Return the number of increases
  n_increases
end
