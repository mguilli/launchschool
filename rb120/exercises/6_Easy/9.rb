# frozen_string_literal: true

# Modify the following so the example code below works.
# Can only define one additional method to do so
module Walkable
  def walk
    puts "#{name} #{gait} forward."
  end
end

class Person
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    'strolls'
  end
end

class Cat
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    'saunters'
  end
end

class Cheetah
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    'runs'
  end
end

mike = Person.new('Mike')
mike.walk
# => 'Mike strolls forward'

kitty = Cat.new('Kitty')
kitty.walk
# => 'Kitty saunters forward'

flash = Cheetah.new('Flash')
flash.walk
# => 'Flash runs forward'
