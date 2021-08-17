# How big is the room?
SQMETERS_TO_SQFEET = 10.7639

print ">> Enter the length of the room in meters: "
length = gets.chomp.to_i
print ">> Enter the width of the room in meters: "
width = gets.chomp.to_i

area_meters = length * width
area_feet = area_meters * SQMETERS_TO_SQFEET

puts "The area of the room is #{area_meters} square meteres" + \
  "(#{area_feet.round(2)} square feet)."
