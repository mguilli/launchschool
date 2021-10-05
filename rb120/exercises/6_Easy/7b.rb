# frozen_string_literal: true

# Has a name and a pet_type
class Pet
  attr_reader :type, :name

  def initialize(pet_type, name)
    @type = pet_type
    @name = name
  end

  def to_s
    "a #{type} named #{name}"
  end
end

# Tracks pets adopted by an owner
class Owner
  attr_reader :name

  def initialize(name)
    @name = name
    @pets = []
  end

  def adopt(pet)
    @pets << pet
  end

  def number_of_pets
    @pets.size
  end

  def print_pets
    puts "#{name} has adopted the following pets:"
    puts @pets
    puts ''
  end
end

# Coordinates the adoption of pets by owners
# Keeps track of which owner adopts which pet
# Maintains a list of unadopted pets
class Shelter
  def initialize
    @adoptions = []
    @unadopted = []
  end

  def adopt(owner, pet)
    @unadopted.delete(pet)

    owner.adopt(pet)
    @adoptions.include?(owner) || @adoptions << owner
  end

  def intake(pet)
    @unadopted << pet
  end

  def number_unadopted
    @unadopted.size
  end

  def print_adoptions
    puts "The Animal Shelter has the following unadopted pets:"
    puts @unadopted
    puts ''

    @adoptions.each(&:print_pets)
  end
end

all_pets = [
  butterscotch = Pet.new('cat',            'Butterscotch'),
  pudding      = Pet.new('cat',            'Pudding'),
  darwin       = Pet.new('bearded dragon', 'Darwin'),
  kennedy      = Pet.new('dog',            'Kennedy'),
  sweetie      = Pet.new('parakeet',       'Sweetie Pie'),
  molly        = Pet.new('dog',            'Molly'),
  chester      = Pet.new('fish',           'Chester'),
  # not adopted 
  Pet.new('dog',      'Asta'),
  Pet.new('dog',      'Laddie'),
  Pet.new('cat',      'Fluffy'),
  Pet.new('cat',      'Kat'),
  Pet.new('cat',      'Ben'),
  Pet.new('parakeet', 'Chatterbox'),
  Pet.new('parakeet', 'Bluebell'),
]

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new

all_pets.each do |pet|
  shelter.intake(pet)
end

shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The Animal shelter has #{shelter.number_unadopted} unadopted pets."

# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin

# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester

# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.
