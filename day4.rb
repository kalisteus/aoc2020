require 'pp'

required_fields = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
optional_fields = ['cid']

# Process all passports and store them as an array of Hashes
# each processed passport is stored as a Hash
passports = []
passport = []
File.foreach('./input/day4.txt') do |line|
  split_line = line.split(' ')

  if split_line.empty?
    # When encoutering an empty line the passport is complete, process and store

    # Split every passport field into 'key, value' arrays
    passport.map! { |entry| entry.split(':')}
    # Map the passport arrays into a hash
    passport_hash = Hash[passport.map { |key, value| [key, value] }]
    # Add the passport hash to the passports array
    passports << passport_hash
    # clear the passport array for a new entry
    passport = []
  else
    # Simply add the line to the array, still processing same passport
    passport.concat split_line
  end
end
# Handle the last passport as well
passport.map! { |entry| entry.split(':')}
passport_hash = Hash[passport.map {|key, value| [key, value]}]
passports << passport_hash

valid_passport_count = 0
passports.each do |passport|
  intersection =  passport.keys.intersection(required_fields)
  if intersection.length == required_fields.length
    # Necessary fields present, passport is valid for now
    invalid_passport = false

    # Validate the fields
    passport.each do |key, value|
      break if invalid_passport
      case key
      when "byr", "iyr", "eyr"
        year = value.to_i
        invalid_passport = true if key === "byr" and (year < 1920 || year > 2002)
        invalid_passport = true if key === "iyr" and (year < 2010 || year > 2020)
        invalid_passport = true if key === "eyr" and (year < 2020 || year > 2030)
      when "hgt"
        if value.end_with? "cm"
          height = value.delete("cm").to_i
          invalid_passport = true if (height < 150 || height > 193)
        elsif value.end_with? "in"
          height = value.delete("in").to_i
          invalid_passport = true if (height < 59 || height > 76)
        else
          invalid_passport = true
        end
      when "hcl"
        if value.start_with?("#")
          invalid_passport = true if ! /^[0-9a-f]{6}$/.match?(value.delete("#"))
        else
          invalid_passport = true
        end
      when "ecl"
        valid_colors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
        invalid_passport = true if !valid_colors.include?(value)
      when "pid"
        valid_integer = !value.to_i.digits.empty?
        invalid_passport = true if valid_integer && value.length != 9
      end
    end
    valid_passport_count += 1 if !invalid_passport
  end
end


puts "Result"
pp valid_passport_count
