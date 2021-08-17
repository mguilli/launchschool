def reverse_sentence(sentence)
  words = sentence.split(' ')
  reversed_words = []

  i = 0
  while i < words.length
    # words[i] returns a string, which cannot be added to an array using '+'
    reversed_words = [words[i]] + reversed_words
    # Alternatively
    # reversed_words.unshift (words[i])
    i += 1
  end

  reversed_words.join(' ')
end

p reverse_sentence('how are you doing')
# expected output: 'doing you are how'