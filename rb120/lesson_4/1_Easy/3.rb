module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

small_car = Car.new
small_car.go_fast
# I am a Car and going super fast!

# Speed#go_fast is executed in the context of the Car class, so when `self` is
# invoked, the `small_car` object is actually invoked. Invoking `self.class` in
# this example is equivalent to invoking `small_car.class`
