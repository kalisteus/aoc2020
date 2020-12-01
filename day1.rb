input = []
input_3d = []
target = 2020

File.foreach('./input/day1.txt') { |line|
  val = line.to_i
  input << val
  if val.digits.length < 4
    input_3d << val
  end
}

int1_1 = 0
int1_2 = 0
int2_1 = 0
int2_2 = 0
int2_3 = 0
input_3d.each do |val_3d|
  input.each do |val|
    if (val_3d + val) == target
      int1_1 = val_3d
      int1_2 = val
    end
    input_3d.each do |val3|
      if (val_3d + val + val3) == target
        int2_1 = val_3d
        int2_2 = val
        int2_3 = val3
      end
    end
  end
end
result1 = int1_1 * int1_2
result2 = int2_1 * int2_2 * int2_3

puts "Result 1"
puts result1
puts "Result 2"
puts result2
