# frozen_string_literal: true

# towable
module Towable
  def tow
    puts 'I can tow a trailer!'
  end
end

# truck
class Truck
  include Towable
end

# car
class Car
end

truck1 = Truck.new
truck1.tow
