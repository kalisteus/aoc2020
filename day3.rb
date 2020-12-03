require 'pp'

# read in the slope pattern
slope_pattern = []
File.foreach('./input/day3.txt') { |line|
  slope_pattern << line.split("\n")[0].split('')
}

y_length = slope_pattern.length
x_length = slope_pattern[0].length

results = []

# x movement, 1st value, positive = right, negative = left
# y movement, 2nd value, positive = down, negative  = up
movements = [
  [1,1],
  [3,1],
  [5,1],
  [7,1],
  [1,2]
]

# loop over every movements input
movements.each { |x_mov,y_mov|
  # init the iterators
  xi = 0
  yi = 0

  # loop until at the bottom
  trees = []
  until yi >= y_length
    trees << slope_pattern[yi][xi] if slope_pattern[yi][xi] === "#"

    # update the iterators
    yi += y_mov
    xi += x_mov
    xi -= x_length if xi >= x_length
  end

  results << trees.length
}
puts "Result"
pp results.inject(:*)
