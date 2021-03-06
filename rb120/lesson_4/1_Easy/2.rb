module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed # edit

  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed # edit

  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

puts Car.ancestors
puts Truck.ancestors
