# Passenger Train. Advanced method of adding wagons
class PassengerTrain < Train
  def add_wagon(wagon)
    super if wagon.type == 'Пассажирский'
  end
end
