# frozen_string_literal: true

def balanced?(str)
  str.scan(/\([^()]*\)/).each do |sub|
    str = str.sub(sub,'')
  end
end

p balanced?('((What) (is this))?')
p balanced?('((What)) (is this))?')

str = '((What)) (is this))?'
puts str.match?(/\(.*\)/)
str = str.gsub(/\([^()]*\)/, '') while str.match?(/\(.*\)/)
p str
