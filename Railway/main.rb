require_relative 'core/modules/manufacturer'
require_relative 'core/modules/instance_counter'

require_relative 'core/stations/station'
require_relative 'core/routes/route'

require_relative 'core/trains/train'
require_relative 'core/trains/passenger_train'
require_relative 'core/trains/cargo_train'

require_relative 'core/wagons/wagon'
require_relative 'core/wagons/passenger_wagon'
require_relative 'core/wagons/cargo_wagon'

puts 'Добро пожаловать в программу по управлению железнодорожной станцией!'

# Main menu and it's routes
def main_menu
  puts '1. Меню станций'
  puts '2. Меню маршрутов'
  puts '3. Меню поездов'
  puts '-----------'
  puts '0. Выход из программы'

  select = gets.chomp.to_s
  main_menu_router(select)
end

def main_menu_router(select)
  case select
  when '1'
    puts '-----------'
    puts ''
    stations_menu
  when '2'
    puts '-----------'
    puts ''
    routes_menu
  when '3'
    puts '-----------'
    puts ''
    trains_menu
  when '0'
    abort('Всего доброго!')
  else
    puts 'Ошибка ввода, выберите доступный вариант.'
    puts '-----------'
    puts ''
    main_menu
  end
end
# ------------------------------------------------------------------

# Stations menu and it's routes
def stations_menu
  puts '1. Создать станцию'
  puts '2. Показать список станций'
  puts '3. Показать список поездов на станции'
  puts '-----------'
  puts '0. Вернуться в главное меню'

  select = gets.chomp.to_s
  stations_menu_router(select)
end

def stations_menu_router(select)
  case select
  when '1'
    puts '-----------'
    puts ''
    create_station
  when '2'
    puts '-----------'
    puts ''
    show_stations
  when '3'
    puts '-----------'
    puts ''
    show_trains
  when '0'
    puts '-----------'
    puts ''
    main_menu
  else
    puts 'Ошибка ввода, выберите доступный вариант.'
    puts '-----------'
    puts ''
    stations_menu
  end
end
# ------------------------------------------------------------------

# Stations methods
def create_station
  puts 'Введите название станции:'
  station_name = gets.chomp.to_s
  Station.new(station_name)

  puts "Станция #{station_name} создана"
  puts '-----------'
  puts ''
  stations_menu
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
  retry
end

def show_stations
  puts 'Список станций:'

  if Station.all.empty?
    puts 'Список пуст'
    puts '-----------'
    puts ''
    return stations_menu
  end

  Station.all.each_key.with_index(1) { |station, index| puts "#{index}. #{station}" }

  puts '-----------'
  puts ''
  stations_menu
end

def show_trains
  check_stations
  check_trains

  puts 'Выберите станцию для вывода списка поездов:'
  select_station
  station = gets.chomp.to_i
  if station > Station.all.length || station < 1
    puts 'Ошибка! Такой станции нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return select_station
  end
  station_names = Station.all.keys
  selected_station = Station.all[station_names[station - 1]]

  puts 'Список поездов:'
  selected_station.traverse_train do |train, index|
    puts "#{index}. Поезд: #{train.number}. Тип: #{train.class.name}. Кол-во вагонов: #{train.wagons.length}."
  end
  puts '-----------'
  puts ''
  stations_menu
end
# ------------------------------------------------------------------

# Routes menu and it's routes
def routes_menu
  puts '1. Создать маршрут'
  puts '2. Добавить станцию'
  puts '3. Удалить станцию'
  puts '4. Показать список маршрутов'
  puts '5. Показать список станций в маршруте'
  puts '-----------'
  puts '0. Вернуться в главное меню'

  select = gets.chomp.to_s
  routes_menu_router(select)
end

def routes_menu_router(select)
  case select
  when '1'
    puts '-----------'
    puts ''
    create_route
  when '2'
    puts '-----------'
    puts ''
    add_station
  when '3'
    puts '-----------'
    puts ''
    delete_station
  when '4'
    puts '-----------'
    puts ''
    show_routes
  when '5'
    puts '-----------'
    puts ''
    show_stations_in_route
  when '0'
    puts '-----------'
    puts ''
    main_menu
  else
    puts 'Ошибка ввода, выберите доступный вариант.'
    puts '-----------'
    puts ''
    routes_menu
  end
end
# ------------------------------------------------------------------

# Routes methods
def create_route
  check_stations

  puts 'Создание маршрута:'

  puts 'Выберите начальную станцию маршрута:'
  select_station
  select_start = gets.chomp.to_i

  if select_start > Station.all.length || select_start < 1
    puts 'Ошибка! Такой станции нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return create_route
  end
  station_names = Station.all.keys
  start_station = Station.all[station_names[select_start - 1]]

  puts 'Выберите конечную станцию маршрута:'
  select_station
  select_end = gets.chomp.to_i
  if select_end > Station.all.length || select_end < 1
    puts 'Ошибка! Такой станции нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return create_route
  end
  end_station = Station.all[station_names[select_end - 1]]

  Route.new(start_station, end_station)

  puts 'Маршрут создан!'
  puts '-----------'
  puts ''
  routes_menu
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
  retry
end

def add_station
  check_routes

  check_stations

  puts 'Выберите маршрут для добавления станции:'
  select_route
  select = gets.chomp.to_i
  if select > Route.all.length || select < 1
    puts 'Ошибка! Такого маршрута нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return add_station
  end
  selected_route = Route.all[select - 1]

  puts 'Укажите название станции:'
  select_station
  new_station = gets.chomp.to_i
  if new_station > Station.all.length || new_station < 1
    puts 'Ошибка! Такой станции нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return add_station
  end
  station_names = Station.all.keys
  selected_station = Station.all[station_names[new_station - 1]]

  if selected_station == selected_route.stations[new_station - 1]
    puts 'Ошибка! Такая станция уже есть в списке, выберите другую.'
    puts '-----------'
    puts ''
    return routes_menu
  end

  selected_route.add_station(selected_station)

  puts 'Станция добавлена!'
  puts '-----------'
  puts ''
  routes_menu
end

def delete_station
  check_routes

  check_stations

  puts 'Выберите маршрут для удаления станции:'
  select_route
  select = gets.chomp.to_i
  if select > Route.all.length || select < 1
    puts 'Ошибка! Такого маршрута нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return delete_station
  end
  selected_route = Route.all[select - 1]

  puts 'Укажите название станции:'
  selected_route.stations.each.with_index(1) do |station, index|
    puts "#{index}. #{station.name}"
  end
  select_station = gets.chomp.to_i
  if select_station > selected_route.stations.length || select_station < 1
    puts 'Ошибка! Такой станции нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return delete_station
  end
  selected_delete_station = selected_route.stations[select_station - 1]

  if selected_delete_station == selected_route.stations.first || selected_delete_station == selected_route.stations.last
    puts 'Ошибка! Данную станцию нельзя удалить.'
    puts '-----------'
    puts ''
    return routes_menu
  end
  selected_route.delete_station(selected_delete_station)

  puts 'Станция удалена!'
  puts '-----------'
  puts ''
  routes_menu
end

def show_stations_in_route
  check_routes

  puts 'Выберите маршрут для просмотра списка станций:'
  select_route
  selected_route = gets.chomp.to_i
  if selected_route > Route.all.length || selected_route < 1
    puts 'Ошибка! Такого маршрута нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return show_stations_in_route
  end

  puts 'Станции выбранного маршрута:'
  Route.all[selected_route - 1].stations.each do |station|
    puts station.name
  end

  puts '-----------'
  puts ''
  routes_menu
end

def select_route
  Route.all.each.with_index(1) { |route, index| puts "#{index}. Маршрут: #{route.stations.first.name} - #{route.stations.last.name}" }
end

def show_routes
  puts 'Список маршрутов:'
  select_route
  puts '-----------'
  puts ''
  routes_menu
end

def select_station
  Station.all.each.with_index(1) { |(name), index| puts "#{index}. #{name}" }
end
# ------------------------------------------------------------------

# Trains menu and it's routes
def trains_menu
  puts '1. Создать поезд'
  puts '2. Назначить маршрут поезду'
  puts '3. Переместить поезд на следующую станцию'
  puts '4. Переместить поезд на предыдущую станцию'
  puts '-----------'
  puts '5. Добавить вагон поезду'
  puts '6. Отцепить вагон от поезда'
  puts '7. Показать список вагонов у поезда'
  puts '8. Занять место или объем в вагоне'
  puts '-----------'
  puts '0. Вернуться в главное меню'

  select = gets.chomp.to_s
  trains_menu_router(select)
end

def trains_menu_router(select)
  case select
  when '1'
    puts '-----------'
    puts ''
    create_train
  when '2'
    puts '-----------'
    puts ''
    add_train_route
  when '3'
    puts '-----------'
    puts ''
    forward_train
  when '4'
    puts '-----------'
    puts ''
    backward_train
  when '5'
    puts '-----------'
    puts ''
    attach_wagon
  when '6'
    puts '-----------'
    puts ''
    unhook_wagon
  when '7'
    puts '-----------'
    puts ''
    wagons_list
  when '8'
    puts '-----------'
    puts ''
    take_wagon_place_or_volume
  when '0'
    puts '-----------'
    puts ''
    main_menu
  else
    puts 'Ошибка ввода, выберите доступный вариант'
    puts '-----------'
    puts ''
    trains_menu
  end
end
# ------------------------------------------------------------------

# Trains methods
def select_train
  Train.all.each.with_index(1) { |(train), index| puts "#{index}. Номер поезда: #{train}" }
end

def create_train
  puts 'Укажите тип поезда:'

  puts '1. Грузовой'
  puts '2. Пассажирский'
  select = gets.chomp.to_i

  case select
  when 1
    puts 'Укажите номер поезда в формате ...-.. (можно без дифиса), где точки любые буквы и цифры:'
    number = gets.chomp.to_s
    puts 'Укажите производителя поезда:'
    manufacturer = gets.chomp.to_s
    CargoTrain.new(number, manufacturer)
  when 2
    puts 'Укажите номер поезда в формате ...-.. (можно без дифиса), где точки любые буквы и цифры:'
    number = gets.chomp.to_s
    puts 'Укажите производителя поезда:'
    manufacturer = gets.chomp.to_s
    PassengerTrain.new(number, manufacturer)
  else
    puts 'Ошибка ввода, выберите доступный вариант'
    puts '-----------'
    puts ''
    create_train
  end

  puts 'Поезд создан!'
  puts '-----------'
  puts ''
  trains_menu
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
  retry
end

def add_train_route
  check_trains

  check_routes

  puts 'Выберите поезд для назначения ему маршрута:'
  select_train
  train = gets.chomp.to_i
  if train > Train.all.length || train < 1
    puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return add_train_route
  end
  train_numbers = Train.all.keys
  selected_train = Train.all[train_numbers[train - 1]]

  puts 'Выберите маршрут для назначения его поезду:'
  select_route
  route = gets.chomp.to_i
  if route > Route.all.length || route < 1
    puts 'Ошибка! Такого маршрута нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return add_train_route
  end
  selected_route = Route.all[route - 1]

  selected_train.add_route(selected_route)

  puts 'Маршрут добавлен!'
  puts '-----------'
  puts ''
  trains_menu
end

def attach_wagon
  check_trains

  puts 'Выберите поезд для добавления вагона'
  select_train
  train = gets.chomp.to_i
  if train > Train.all.length || train < 1
    puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return attach_wagon
  end
  train_numbers = Train.all.keys
  selected_train = Train.all[train_numbers[train - 1]]

  if selected_train.class.name == 'CargoTrain'
    puts 'Укажите производителя вагона:'
    manufacturer = gets.chomp.to_s
    puts 'Укажите объем вагона:'
    places = gets.chomp.to_i
    wagon = CargoWagon.new(manufacturer, places)
  else
    puts 'Укажите производителя вагона:'
    manufacturer = gets.chomp.to_s
    puts 'Укажите кол-во пассажирских мест в вагоне:'
    volume = gets.chomp.to_i
    wagon = PassengerWagon.new(manufacturer, volume)
  end
  selected_train.add_wagon(wagon)

  puts 'Вагон добавлен!'
  puts '-----------'
  puts ''
  trains_menu
end

def unhook_wagon
  check_trains

  puts 'Выберите поезд для удаления вагона'
  select_train
  train = gets.chomp.to_i
  if train > Train.all.length || train < 1
    puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return unhook_wagon
  end
  train_numbers = Train.all.keys
  selected_train = Train.all[train_numbers[train - 1]]

  if selected_train.wagons.length.zero?
    puts 'У данного поезда нет вагонов.'
    puts '-----------'
    puts ''
    return trains_menu
  end

  selected_train.delete_wagon

  puts 'Вагон удален!'
  puts '-----------'
  puts ''
  trains_menu
end

def wagons_list
  check_trains

  puts 'Выберите поезд для просмотра списка вагонов:'
  select_train
  train = gets.chomp.to_i
  if train > Train.all.length || train < 1
    puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return select_train
  end
  train_numbers = Train.all.keys
  selected_train = Train.all[train_numbers[train - 1]]

  if selected_train.wagons.length.zero?
    puts 'У данного поезда нет вагонов.'
    puts '-----------'
    puts ''
    return trains_menu
  end

  puts 'Список вагонов:'
  selected_train.traverse_wagon do |wagon, index|
    if wagon.is_a? (PassengerWagon)
      puts "#{index}. Вагон: #{wagon.number}. Тип: #{wagon.type}. Кол-во свободных мест: #{wagon.free_places}. Кол-во занятых мест: #{wagon.busy_places}"
    else
      puts "#{index}. Вагон: #{wagon.number}. Тип: #{wagon.type}. Кол-во свободного объема: #{wagon.free_volume}. Кол-во занятого объема: #{wagon.busy_volume}"
    end
  end
  puts '-----------'
  puts ''
  trains_menu
end

def forward_train
  check_trains

  puts 'Выберите поезд для движения к следующей станции:'
  select_train
  train = gets.chomp.to_i
  if train > Train.all.length || train < 1
    puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return forward_train
  end

  train_numbers = Train.all.keys
  selected_train = Train.all[train_numbers[train - 1]]
  if selected_train.route == ''
    puts 'Ошибка! Не назначен маршрут для этого поезда.'
    puts '-----------'
    puts ''
    return trains_menu
  end
  move = selected_train.move_forward

  puts "Поезд прибыл на станцию: #{move.name}"
  puts '-----------'
  puts ''
  trains_menu
end

def backward_train
  check_trains

  puts 'Выберите поезд для движения к предыдущей станции:'
  select_train
  train = gets.chomp.to_i
  if train > Train.all.length || train < 1
    puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return backward_train
  end

  train_numbers = Train.all.keys
  selected_train = Train.all[train_numbers[train - 1]]
  if selected_train.route == ''
    puts 'Ошибка! Не назначен маршрут для этого поезда.'
    puts '-----------'
    puts ''
    return trains_menu
  end
  move = selected_train.move_backward

  puts "Поезд прибыл на станцию: #{move.name}"
  puts '-----------'
  puts ''
  trains_menu
end

def take_wagon_place_or_volume
  check_trains

  puts 'Выберите поезд для просмотра списка вагонов:'
  select_train
  train = gets.chomp.to_i
  if train > Train.all.length || train < 1
    puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return select_train
  end
  train_numbers = Train.all.keys
  selected_train = Train.all[train_numbers[train - 1]]

  if selected_train.wagons.length.zero?
    puts 'У данного поезда нет вагонов.'
    puts '-----------'
    puts ''
    return trains_menu
  end

  puts 'Выберите вагон для занятия места или объема:'
  selected_train.traverse_wagon do |wagon, index|
    if wagon.is_a? (PassengerWagon)
      puts "#{index}. Вагон: #{wagon.number}. Тип: #{wagon.type}. Кол-во свободных мест: #{wagon.free_places}. Кол-во занятых мест: #{wagon.busy_places}"
    else
      puts "#{index}. Вагон: #{wagon.number}. Тип: #{wagon.type}. Кол-во свободного объема: #{wagon.free_volume}. Кол-во занятого объема: #{wagon.busy_volume}"
    end
  end
  wagon = gets.chomp.to_i
  if wagon > Wagon.all.length || wagon < 1
    puts 'Ошибка! Такого вагона нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return take_wagon_place_or_volume
  end
  selected_wagon = selected_train.wagons[wagon - 1]

  if selected_wagon.is_a? (PassengerWagon)
    selected_wagon.take_place
    puts 'Вы заняли одно пассажирское место:'
  else
    puts 'Укажите объем, который вы хотите занять:'
    value = gets.chomp.to_i
    selected_wagon.take_volume(value)
    puts 'Объем занят:'
  end
  puts '-----------'
  puts ''
  trains_menu
rescue RuntimeError => e
  puts "Ошибка: #{e}"
  trains_menu
end
# ------------------------------------------------------------------

# Checks
def check_stations
  if Station.all.empty? || Station.all.length < 2
    puts 'Список станций пуст или создана всего одна станция, создайте новую станцию!'
    puts '-----------'
    puts ''
    stations_menu
  end
end

def check_routes
  if Route.all.empty?
    puts 'Список маршрутов пуст, создайте маршрут!'
    puts '-----------'
    puts ''
    routes_menu
  end
end

def check_trains
  if Train.all.empty?
    puts 'Список поездов пуст, создайте поезд!'
    puts '-----------'
    puts ''
    trains_menu
  end
end

main_menu
