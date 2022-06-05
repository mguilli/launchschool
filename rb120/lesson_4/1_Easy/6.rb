class Cube
  # accessor method
  # attr_accessor :volume

  def initialize(volume)
    @volume = volume
  end

  # manual accessor methods
  def volume
    @volume
  end

  def volume=(amount)
    @volume = amount
  end
end
