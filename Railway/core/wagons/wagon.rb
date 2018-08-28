# Wagons of trains. Types of wagons: passenger, cargo.
class Wagon
  include Manufacturer
  attr_reader :type
  def initialize(type, manufacturer = nil)
    @type = type
    @manufacturer = manufacturer
  end
end
