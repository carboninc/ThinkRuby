# Railway Station
class Station
  def initialize(name)
    @name = name
    @trains_on_station = []
  end

  def train_arrival(type)
    if %w[пассажирский грузовой].include?(type)
      @trains_on_station.push(type)
    else
      puts 'Поезд может быть только грузовым или пассажирским'
    end
  end

  def trains_on_station
    puts "Поездов на странции в данный момент: #{@trains_on_station.length}"
  end

  def type_trains_on_station
    cargo = @trains_on_station.select { |train| train == 'грузовой' }
    passenger = @trains_on_station.select { |train| train == 'пассажирский' }

    puts "Кол-во грузовых поездов: #{cargo.length}"
    puts "Кол-во пассажирских поездов: #{passenger.length}"
  end

  def train_departure(type)
    if %w[пассажирский грузовой].include?(type) && !@trains_on_station.empty?
      @trains_on_station.delete_at(@trains_on_station.find_index(type))
    else
      puts 'Ошибка при указании типа поезда или такого поезда нет на станции'
    end
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
    if [@stations.first, @stations.last].include?(name_station)
      puts 'Эту станцию нельзя удалить'
    else
      @stations.delete_at(@stations.find_index(name_station))
    end
  end

  def show_stations
    puts 'Список станций данного маршрута:'
    @stations.each do |station|
      puts station
    end
  end
end

# Train Class
class Train
  attr_accessor :speed
  def initialize(number, type, count)
    @train = { train: { number: number, type: type, wagons: count } }
    @speed = 0
  end

  def wagons_count
    puts "Кол-во вагонов в поезде: #{@train[:train][:wagons]}"
  end

  def add_or_delete_wagons(type)
    if @speed.zero?
      if type == 'add' && @train[:train][:wagons] > 0
        @train[:train][:wagons] += 1
      elsif type == 'delete' && @train[:train][:wagons] > 0
        @train[:train][:wagons] -= 1
      else
        'У поезда нет вагонов'
      end
    else
      puts 'Поезд сначала должен остановиться'
    end
  end

  def route(route)
    @route = route
    @current_station = 0
    puts "Поезд начинает свой маршрут со станции: #{@route.stations.first}"
  end

  def move_forward
    if @current_station >= @route.stations.length - 1
      puts "#{@route.stations.last} - конечная станция"
    else
      puts "Станция: #{@route.stations[@current_station + 1]}"
      @current_station += 1
    end
  end

  def move_backward
    if @current_station.zero?
      puts "#{@route.stations.first} - начальная станция"
    else
      puts "Станция: #{@route.stations[@current_station - 1]}"
      @current_station -= 1
    end
  end

  def current_station
    if @current_station.zero?
      puts "Начальная станция, следующая станция #{@route.stations[1]}"
    elsif @current_station == @route.stations.length - 1
      puts "Конечная станция, предыдущая станция #{@route.stations[-2]}"
    else
      puts "Вы находитесь на станции: #{@route.stations[@current_station]}"
      puts "Предыдущая станция: #{@route.stations[@current_station - 1]}"
      puts "Следующая станция: #{@route.stations[@current_station + 1]}"
    end
  end
end
