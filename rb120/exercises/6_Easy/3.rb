class House
  include Comparable

  attr_reader :price

  def initialize(price)
    @price = price
  end

  def <=>(other)
    price <=> other.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

# Home 1 is cheaper
# Home 2 is more expensive

# We can gain the ability to use equivalence comparisons bewteen objects by
# including the `Comparable` module in our class, and defining a `<=>` method.
# The `<=>` method directs Ruby towards how we want to compare two objects.

# Further Exploration
# Using `Comparable` in this manner assumes price is the only way to evaluate a
# house's "greatness". Home buyers look at a number of factors when buying a
# home, including price, size, and location. A better way of comparing home
# prices here might be to just compare the prices directly, via `home1.price <
# home2.price`. This way one may be able to add other home attributes, without
# prioritizing price a sole evaluation method.
