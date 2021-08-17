# Reverse it part 2
def reverse_words(string)
  words = []
  string.split.each do |word|
    word.length > 5 ? words.push(word.reverse) : words.push(word)
  end

  words.join(' ')
end

puts reverse_words('Professional')          # => lanoisseforP
puts reverse_words('Walk around the block') # => Walk dnuora the kcolb
puts reverse_words('Launch School')         # => hcnuaL loohcS