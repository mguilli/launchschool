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

# Has a name
# Keeps track of the pets adoped
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
class Shelter
  def initialize
    @adoptions = []
  end

  def adopt(owner, pet)
    owner.adopt(pet)
    @adoptions.include?(owner) || @adoptions << owner
  end

  def print_adoptions
    @adoptions.each(&:print_pets)
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
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
