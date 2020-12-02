valid = 0
valid2 = 0

File.foreach('./input/day2.txt') { |line|
  rule_pw = line.split(': ')
  # break down the rule
  amount_letter = rule_pw[0].split(' ')
  amount_min_max = amount_letter[0].split('-')
  amount_min = amount_min_max[0].to_i
  amount_max = amount_min_max[1].to_i

  # iterator for rule1
  ci = 0
  # control bools for rule 2
  i1valid = false
  i2valid = false

  # iterate over password characters with index (starting at 1)
  rule_pw[1].each_char.with_index(1){|c, i|
    if c === amount_letter[1]
      ci += 1
      i1valid = true if i === amount_min
      i2valid = true if i === amount_max
    end

  }

  # check rule1 for validity
  if amount_min <= ci && amount_max >= ci
    valid += 1
  end

  # check rule 2 for validity
  if (i1valid || i2valid) && (i1valid != i2valid)
    valid2 += 1
  end
}

puts "Valid passwords:"
puts valid
puts "Valid passwords part 2:"
puts valid2
