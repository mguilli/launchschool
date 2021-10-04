# frozen_string_literal: true

# class Person
#   attr_accessor :name
# 
#   def initialize(name)
#     @name = name
#   end
# end
# 
# bob = Person.new('bob')
# bob.name                  # => 'bob'
# bob.name = 'Robert'
# bob.name                  # => 'Robert'

# class Person
  # attr_accessor :first_name, :last_name

  # def initialize(full_name)
  #   @first_name, @last_name = full_name.split
  #   @last_name ||= ''
  # end

  # def name
  #   first_name + ' ' + last_name
  # end
# end

# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name full_name
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name full_name
  end

  private

  def parse_full_name(full_name)
    self.first_name, self.last_name = full_name.split
    self.last_name ||= ''
  end
end

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
bob.first_name            # => 'John'
bob.last_name             # => 'Adams'
