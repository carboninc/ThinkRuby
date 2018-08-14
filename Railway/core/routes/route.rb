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
    @stations.delete_at(@stations.find_index(name_station))
  end
end
