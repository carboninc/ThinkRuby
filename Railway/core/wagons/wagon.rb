# Wagons of trains. Types of wagons: passenger, cargo.
class Wagon
  include Manufacturer
  attr_reader :type, :number

  @@wagons = []

  def self.all
    @@wagons
  end

  def initialize(type, manufacturer)
    @number = rand(0...999_999)
    @type = type
    @manufacturer = manufacturer.to_s
    validate!
    @@wagons << self
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  private

  def validate!
    raise 'Укажите валидный тип вагона. Доступные варианты: Cargo или Passenger' if type != 'Cargo' && type != 'Passenger'
    raise 'Укажите производителя вагона' if manufacturer.empty?
    true
  end
end
