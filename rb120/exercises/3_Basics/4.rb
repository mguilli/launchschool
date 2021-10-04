# frozen_string_literal: true

# v
class Vehicle
  def start_engine
    'Ready to go!'
  end
end

# truck
class Truck < Vehicle
  def start_engine(speed)
    super() + " Drive #{speed}, please!"
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')
