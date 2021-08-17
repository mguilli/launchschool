# Sum or Product of Consecutive Integers

# The operations hash provides a description and an operator for each choice
operations = {
              s: { desc: 'sum', operator: :+ },
              p: { desc: 'product', operator: :* }
             }

print ">> Please enter an integer greater than 0: "
number = gets.chomp.to_i

puts ">> What operation would you like to perform?"
operations.each { |k, v| puts ">>   Enter '#{k}' to compute the #{v[:desc]}" }
print ">> "

selected = gets.chomp.to_sym

unless operations.keys.include?(selected)
  abort("Program Terminated - invalid choice selected!!")
end

# For selected = 's', reduce is passed the (:+) argument from operations hash
result = (1..number).reduce(operations[selected][:operator])

puts "The #{operations[selected][:desc]} of the integers between 1" \
     " and #{number} is #{result}."
