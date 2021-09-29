# frozen_string_literal: true

module Towable
end

class Vehicle
  @@vehicles = 0

  def initialize
    @@vehicle += 1
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def self.total
    @@vehicles
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
end

class MyTruck < Vehicle
  include Towable

  NUMBER_OF_DOORS = 2
end
