# Railway Station
class Station
  include InstanceCounter

  attr_reader :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def train_arrival(train)
    @trains.push(train)
  end

  def trains
    @trains.length
  end

  def trains_by_type
    passengers = @trains.select { |train| train.class.name == 'PassengerTrain' }
    cargos = @trains.select { |train| train.class.name == 'CargoTrain' }
    @trains_by_type = [passengers.length, cargos.length]
  end

  def train_departure(train)
    @trains.delete(train)
  end
end
