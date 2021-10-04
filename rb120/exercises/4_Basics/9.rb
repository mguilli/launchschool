# frozen_string_literal: true

# person
class Person
  def age=(age)
    @age = twice age
  end

  def age
    twice @age
  end

  private

  def twice(num)
    num * 2
  end
end

person1 = Person.new
person1.age = 20
puts person1.age
