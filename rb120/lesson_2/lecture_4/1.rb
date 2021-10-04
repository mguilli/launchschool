# frozen_string_literal: true

# 1
class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

# still 1
class BullDog < Dog
  def swim
    'can\'t swim!'
  end
end

teddy = Dog.new
puts teddy.speak
puts teddy.swim

buffy = BullDog.new
puts buffy.speak
puts buffy.swim
