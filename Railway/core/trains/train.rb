# Train Class
class Train
  attr_accessor :speed
  attr_reader :number
  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons.push(wagon) if @speed.zero?
  end

  def delete_wagon
    @wagons.pop if @speed.zero?
  end

  def route(route)
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
    if @current_station.zero?
      @route.stations[1]
    elsif @current_station == @route.stations.length - 1
      @route.stations[-2]
    else
      current_station = @route.stations[@current_station]
      prev_station = @route.stations[@current_station - 1]
      next_station = @route.stations[@current_station + 1]
      @current_stations = [prev_station, current_station, next_station]
    end
  end
end
