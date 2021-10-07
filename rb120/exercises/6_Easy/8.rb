# frozen_string_literal: true

# Expander
class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    # Before Ruby 2.7, could not call private methods with explicit self
    self.expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander
