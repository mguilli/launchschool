class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# Outside of an instance method, `self` refers to the class itself.
# In this case, we are defining a class method
puts Cat.cats_count # => 0
Cat.new('stray')
puts Cat.cats_count # => 1
