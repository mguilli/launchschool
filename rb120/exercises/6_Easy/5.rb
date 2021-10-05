class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata
puts thing.dupdata

# When we assign a new instance of `Something` to the variable `thing`, the
# string 'Hello' is assigned to `thing`'s `@data` instance variable.
# Calling `thing.dupdata` will return 'HelloHello'.
# Calling `Something.dupdata` will invoke the class method `dupdata`, as opposed
# to the instance method of the same name. `Something.dupdata` will return the
# string 'ByeBye'
