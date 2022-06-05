class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# Here `self` refers to the calling object, which is an instance of the Cat
# class.
# Example:

kitty = Cat.new('calico') # < Instance of the cat class
puts kitty.age # => 0
kitty.make_one_year_older # `self` is referring to `kitty`
puts kitty.age # => 1
