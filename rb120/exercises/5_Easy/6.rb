# frozen_string_literal: true

# flight
class Flight
  # attr_accessor :database_handle
  # remove the access to @database_handle, as it is most likely an
  # implementation detail

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end
