# Railway Station
class Station
  attr_reader :name
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

  def trains_by_type
    passengers = @trains.select { |train| train.class.name == 'PassengerTrain' }
    cargos = @trains.select { |train| train.class.name == 'CargoTrain' }
    @trains_by_type = [passengers.length, cargos.length]
  end

  def train_departure(train)
    @trains.delete(train)
  end
end
