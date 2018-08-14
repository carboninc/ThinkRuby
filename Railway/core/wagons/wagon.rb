# Wagons of trains. Types of wagons: passenger, cargo.
class Wagon
  attr_reader :type
  def initialize(type)
    @type = type
  end
end
