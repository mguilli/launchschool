# When will I Retire?

print ">> What is your age? "
age = gets.chomp.to_i
print ">> At what age would you like to retire? "
retire_age = gets.chomp.to_i

year = Time.now.year
years_left = retire_age - age
retire_year = year + years_left

puts "\nIt's #{year}. You will retire in #{retire_year}."
puts "You only have #{years_left} years of work to go!"
