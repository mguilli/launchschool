# Odd Numbers

# (1..99).each { |x| puts x if x.odd?}

# More terse
puts (1..99).select(&:odd?)