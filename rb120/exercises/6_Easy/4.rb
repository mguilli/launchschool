# frozen_string_literal: true

# Transform
class Transform
  def initialize(str)
    @word = str
  end

  def uppercase
    @word.upcase
  end

  def self.lowercase(str)
    str.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

# ABC
# xyz
