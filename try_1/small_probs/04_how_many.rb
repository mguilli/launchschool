# How Many?

def count_occurrences(arr)
  result = Hash.new(0)
  arr.each { |x| result[x] += 1 }
  result.each { |k,v| puts "#{k} => #{v}" }
  # arr.uniq.each { |vehicle| puts "#{vehicle} => #{arr.count(vehicle)}" }
end

vehicles = ['car', 'car', 'truck', 'car', 'SUV', 'truck', 'motorcycle', 'motorcycle', 'car', 'truck']

count_occurrences(vehicles)