# frozen_string_literal: true

# Refactor to use a common superclass, and inherit behavior as needed
class Vehicle
  WHEELS = 0

  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    self.class::WHEELS
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  WHEELS = 4
end

class Motorcycle < Vehicle
  WHEELS = 2
end

class Truck < Vehicle
  attr_reader :payload

  WHEELS = 6

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end
end

class Boat < Vehicle
end

ford = Truck.new('Ford', 'F150', 1000)
p ford
puts ford.wheels

skiboat = Boat.new('Yamaha', 'JetBoat')
p skiboat
puts skiboat.wheels
