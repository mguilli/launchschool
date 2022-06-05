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

# @@cats_count is a class variable that is shared among all instances of the
# class
# When a new object is instantiated from the Cat class, @@cat_counts is
# incremented.
# The value if @@cats_count will always be the total number of Cat objects
# instantiated
