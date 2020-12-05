require 'pp'

def get_column_no(boarding_pass)
  columns = (0..7).to_a
  pass_array = boarding_pass.split('')

  pass_array.last(3).each do |letter|
    half = columns.length / 2
    # "Left"; take lower half
    columns = columns.first(half) if letter == "L"
      # "Right"; take higher half
    columns = columns.last(half) if letter == "R"
  end

  columns[0]
end

def get_row_no(boarding_pass)
  rows = (0..127).to_a
  pass_array = boarding_pass.split('')

  pass_array.first(7).each do |letter|
    half = rows.length / 2
    # "Front"; take lower half
    rows = rows.first(half) if letter == "F"
      # "Back"; take higher half
    rows = rows.last(half) if letter == "B"
  end

  rows[0]
end

def get_seat_id(boarding_pass)
  row_no = get_row_no(boarding_pass)
  column_no = get_column_no(boarding_pass)

  (row_no * 8) + column_no
end

ids = []
File.foreach('./input/day5.txt') { |line|
  ids << get_seat_id(line.split("\n")[0])
}
all_ids = (ids.min..ids.max).to_a
my_id = all_ids - ids

puts "Hightest Seat ID:"
pp ids.max
puts "My Seat ID:"
pp my_id[0]
