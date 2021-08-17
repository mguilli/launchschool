# Array Average

def average(arr)
  (arr.sum / arr.size.to_f).round(2)
end

puts average([1, 5, 87, 45, 8, 8])
puts average([9, 47, 23, 95, 16, 52])
