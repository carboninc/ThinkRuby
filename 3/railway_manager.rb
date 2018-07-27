# Railway Station
class Station
  def initialize(name)
    @name = name
    @trains = []
  end

  def train_arrival(train)
    @trains.push(train)
  end

  def trains
    @trains.length
  end

  def type_of_trains(type)
    type_of_trains = @trains.select { |train| train.type == type }
    type_of_trains.length
  end

  def train_departure(train)
    @trains.include?(train) ? @trains.delete(train) : nil
  end
end

# Trains Routes
class Route
  attr_reader :stations
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(name_station)
    @stations.insert(-2, name_station)
  end

  def delete_station(name_station)
    [@stations.first, @stations.last].include?(name_station) ? nil : @stations.delete_at(@stations.find_index(name_station))
  end
end

# Train Class
class Train
  attr_reader :type, :wagons
  attr_accessor :speed
  def initialize(number, type, count)
    @number = number
    @type = type
    @wagons = count
    @speed = 0
  end

  def add_wagon
    @speed.zero? ? @wagons += 1 : nil
  end

  def delete_wagon
    @speed.zero? && @wagons > 0 ? @wagons -= 1 : nil
  end

  def route(route)
    @route = route
    @current_station = 0
  end

  def move_forward
    if @current_station >= @route.stations.length - 1
      @route.stations.last
    else
      @route.stations[@current_station + 1]
      @current_station += 1
    end
  end

  def move_backward
    if @current_station.zero?
      @route.stations.first
    else
      @route.stations[@current_station - 1]
      @current_station -= 1
    end
  end

  def current_station
    if @current_station.zero?
      @route.stations[1]
    elsif @current_station == @route.stations.length - 1
      @route.stations[-2]
    else
      @route.stations[@current_station]
      @route.stations[@current_station - 1]
      @route.stations[@current_station + 1]
    end
  end
end
