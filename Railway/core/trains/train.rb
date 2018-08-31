# Train Class
class Train
  include Manufacturer
  include InstanceCounter

  attr_accessor :speed
  attr_reader :number, :route, :wagons

  NUMBER_FORMAT = /^(\d|[a-zа-я]){3}-?(\d|[a-zа-я]){2}$/i
  @@trains = {}

  class << self
    def all
      @@trains
    end

    def find(number)
      @@trains[number]
    end
  end

  def initialize(number, manufacturer)
    @number = number.to_s
    @manufacturer = manufacturer.to_s
    @wagons = []
    @speed = 0
    @route = ''
    validate!
    @@trains[number] = self
    register_instance
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  def add_wagon(wagon)
    @wagons.push(wagon) if @speed.zero?
  end

  def delete_wagon
    @wagons.pop if @speed.zero?
  end

  def add_route(route)
    @route = route
    @current_station = 0
  end

  def move_forward
    if @current_station >= @route.stations.length - 1
      @route.stations.last
    else
      @current_station += 1
      @route.stations[@current_station]
    end
  end

  def move_backward
    if @current_station.zero?
      @route.stations.first
    else
      @current_station -= 1
      @route.stations[@current_station]
    end
  end

  def current_station
    return @route.stations[1] if @current_station.zero?
    return @route.stations[-2] if @current_station == @route.stations.length - 1

    @current_stop = [
      @route.stations[@current_station - 1],
      @route.stations[@current_station],
      @route.stations[@current_station + 1]
    ]
  end

  private

  def validate!
    raise 'Номер поезда не должен быть пустым!' if number.empty?
    raise 'Укажите валидный номер поезда в формате ...-.., где точки это любые символы и цифры' if number !~ NUMBER_FORMAT
    raise 'Укажите производителя поезда!' if manufacturer.empty?
    true
  end
end
