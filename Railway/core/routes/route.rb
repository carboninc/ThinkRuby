# Trains Routes
class Route
  include InstanceCounter
  attr_reader :stations

  @@routes = []

  def self.all
    @@routes
  end

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
    @@routes << self
    register_instance
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  def add_station(name_station)
    @stations.insert(-2, name_station)
  end

  def delete_station(name_station)
    @stations.delete_at(@stations.find_index(name_station))
  end

  private

  def validate!
    @stations.each do |station|
      return raise 'В маршрут можно добавить только экземпляр класса Station' if station.is_a?(String) || station.is_a?(Numeric)
    end
    raise 'Нельзя указывать станцию одновременно и начальной и конечной' if @stations[0] == @stations[-1]
    true
  end
end
