# Repeat Yourself
def repeat(string, integer)
  integer.times { puts string } if integer.is_a?(Integer)
end

repeat("Hello", 3)
puts "-----"
repeat("I see you!", 6)
puts "-----"
repeat("Does this work?", false)
