# frozen_string_literal: true

# Ex 1
class MyCar
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  attr_reader :speed, :year
  attr_accessor :color

  def speedup(velocity)
    @speed += velocity
  end

  def brake(velocity)
    speedup(-velocity)
  end

  def shutoff
    @speed = 0
  end

  def spray_paint(color)
    self.color = color
  end
end

kia = MyCar.new(2019, 'white', 'optima')
puts kia.speed
kia.speedup(10)
puts kia.speed
kia.brake(5)
puts kia.speed
kia.shutoff
puts kia.speed

puts kia.color
kia.color = 'black'
puts kia.color
kia.spray_paint 'red'
puts kia.color

puts kia.year
