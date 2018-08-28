# Train Class
class Train
  include Manufacturer
  include InstanceCounter

  attr_accessor :speed
  attr_reader :number, :route, :wagons

  @@trains = []

  def self.find(number)
    @@trains.select { |train| train.number == number }
  end

  def initialize(number, manufacturer = nil)
    @number = number
    @manufacturer = manufacturer
    @wagons = []
    @speed = 0
    @route = ''
    @@trains << self
    register_instance
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

    current_stop = [
      @route.stations[@current_station - 1],
      @route.stations[@current_station],
      @route.stations[@current_station + 1]
    ]
  end
end
