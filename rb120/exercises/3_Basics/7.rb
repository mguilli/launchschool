# frozen_string_literal: true

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new('Black')
cat1.color

# Lookup path = [Cat, Animal]
# Lookup stops once a matching method name is found
p cat1.class.ancestors
