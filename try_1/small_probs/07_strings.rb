# Stringy Strings

def stringy(length, first_num=1)
  return(puts "Bad input!!!") unless length.is_a?(Integer) && length >= 0

  values = ['1', '0'].cycle
  # Any first_num other than 0 will cause the digits_string to start with 1
  values.next if first_num == 0

  digits_string = ''
  length.times { |i| digits_string << values.next }
  digits_string
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
