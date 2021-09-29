# frozen_string_literal: true

# Matching parentheses

def balanced?(str)
  # tracker = 0
  # str.scan(/[()]/).each do |char|
  #   # tracker += (char == '(' ? 1 : -1)
  #   tracker += [1, -1][char <=> '(']
  #   break if tracker.negative?
  # end
  # tracker.zero?

  # str.scan(/[()]/).reduce(0) { |s, c| s.negative? ? (return false) : (s + [1, -1][c <=> '(']) }.zero?

  str = str.gsub(/\([^()]*\)/, '') while str.match?(/\(.*\)/)
  !str.match?(/[()]/)
end

puts balanced?('What (is) this?') == true
puts balanced?('What is) this?') == false
puts balanced?('What (is this?') == false
puts balanced?('((What) (is this))?') == true
puts balanced?('((What)) (is this))?') == false
puts balanced?('Hey!') == true
puts balanced?(')Hey!(') == false
puts balanced?('What ((is))) up(') == false
