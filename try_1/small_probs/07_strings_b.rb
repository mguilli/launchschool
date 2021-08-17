# Stringy Strings

def stringy(length, first_num=1)
  first_num = 1 if first_num != 0
  digits = []

  return(puts "Bad input!!!") unless length.is_a?(Integer) && length >= 0

  # set the end of the range to either length+0, or length+1
  range_end = length + first_num

  (first_num...range_end).each do |i|
    digit = i.even? ? 0 : 1
    digits << digit
  end

  digits.join
end

puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'

puts stringy(6, 0) == '010101'
puts stringy(9, 0) == '010101010'
puts stringy(4, 0) == '0101'
puts stringy(7, 0) == '0101010'

puts stringy("Harold") == '0101'
puts stringy(8, 'h')
