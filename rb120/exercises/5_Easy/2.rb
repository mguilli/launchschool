# frozen_string_literal: true

# original
# class Pet
#   attr_reader :name
# 
#   def initialize(name)
#     @name = name.to_s
#   end
# 
#   def to_s
#     @name.upcase!
#     "My name is #{@name}."
#   end
# end

# revised
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name # 'Fluffy'
puts fluffy      # 'My name is FLUFFY.'
puts fluffy.name # 'FLUFFY'
puts name        # 'FLUFFY'

# Further exploration
name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
