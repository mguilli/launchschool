# What could you add to this class to simplify it and remove two methods from
# the class definition while still maintaining the same functionality?
class BeesWax
  # add and accessor method
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  # Remove manual getter/setter methods
  # def type
  #   @type
  # end

  # def type=(t)
  #   @type = t
  # end

  def describe_type
    # Change @type to type
    puts "I am a #{type} of Bees Wax"
  end
end
