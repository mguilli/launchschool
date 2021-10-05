module Drivable
  def drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive

# We need to remove the explicit `self` from the `drive` method definition.
# `self` in this use case creates a module method, where we want a mixin method
