# frozen_string_literal: true

# Counting Cats
class Cat
  @@total_cats = 0

  def initialize
    @@total_cats += 1
  end

  def self.total
    @@total_cats
  end
end

kitty1 = Cat.new
kitty2 = Cat.new
puts Cat.total

