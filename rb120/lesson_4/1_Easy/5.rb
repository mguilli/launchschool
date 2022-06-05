class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  attr_accessor :deliveryman

  def initialize(name)
    @name = name
  end

  def testing
    @coolman = 4
  end
end

# Pizza has an instance variable, which can be discerned by the fact that there
# is a `@` symbol prepended to the variable name

p Fruit.new('').instance_variables
p Pizza.new('').instance_variables
