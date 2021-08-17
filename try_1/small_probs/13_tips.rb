# Tip calculator

print ">> What is the bill amount? "
bill = gets.chomp.to_f
print ">> What is the tip percentage? "
rate = gets.chomp.to_f / 100

tip = bill * rate
total = tip + bill

puts "\nThe tip is $#{format("%.2f",tip)}"
puts "The total is $#{format("%.2f",total)}"