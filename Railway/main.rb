require_relative 'core/stations/station'
require_relative 'core/routes/route'

require_relative 'core/trains/train'
require_relative 'core/trains/passenger_train'
require_relative 'core/trains/cargo_train'

require_relative 'core/wagons/wagon.rb'

@stations = []
@trains = []
@routes = []
@wagons = []

puts 'Добро пожаловать в программу по управлению железнодорожной станцией!'

# Main menu and it's routes
def main_menu
  puts '1. Меню станций'
  puts '2. Меню маршрутов'
  puts '3. Меню поездов'
  puts '-----------'
  puts '0. Выход из программы'

  select = gets.chomp.to_i
  main_menu_router(select)
end

def main_menu_router(select)
  case select
  when 1
    puts '-----------'
    puts ''
    stations_menu
  when 2
    puts '-----------'
    puts ''
    routes_menu
  when 3
    puts '-----------'
    puts ''
    trains_menu
  when 0
    abort('Всего доброго!')
  else
    puts 'Ошибка ввода, выберите доступный вариант.'
    puts '-----------'
    puts ''
    main_menu
  end
end

# Stations menu and it's routes
def stations_menu
  puts '1. Создать станцию'
  puts '2. Показать список станций'
  puts '-----------'
  puts '0. Вернуться в главное меню'

  select = gets.chomp.to_i
  stations_menu_router(select)
end

def stations_menu_router(select)
  case select
  when 1
    puts '-----------'
    puts ''
    create_station
  when 2
    puts '-----------'
    puts ''
    show_stations
  when 0
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

# Stations methods
def create_station
  puts 'Введите название станции:'
  station_name = gets.chomp.to_s
  @stations << Station.new(station_name)

  puts "Станция #{station_name} создана"
  puts '-----------'
  puts ''
  stations_menu
end

def show_stations
  puts 'Список станций:'

  @stations.each do |station|
    puts station.name
  end

  puts '-----------'
  puts ''
  stations_menu
end

# Routes menu and it's routes
def routes_menu
  puts '1. Создать маршрут'
  puts '2. Добавить станцию'
  puts '3. Удалить станцию'
  puts '4. Показать список маршрутов'
  puts '5. Показать список станций в маршруте'
  puts '-----------'
  puts '0. Вернуться в главное меню'

  select = gets.chomp.to_i
  routes_menu_router(select)
end

def routes_menu_router(select)
  case select
  when 1
    puts '-----------'
    puts ''
    create_route
  when 2
    puts '-----------'
    puts ''
    add_station
  when 3
    puts '-----------'
    puts ''
    delete_station
  when 4
    puts '-----------'
    puts ''
    show_routes
  when 5
    puts '-----------'
    puts ''
    show_stations_in_route
  when 0
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

# Routes methods
def create_route
  check_stations

  puts 'Создание маршрута:'

  puts 'Введите начальную станцию маршрута:'
  select_station
  select_start = gets.chomp.to_i
  if select_start > @stations.length || select_start < 1
    puts 'Ошибка! Такой станции нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return create_route
  end
  start_station = @stations[select_start - 1]

  puts 'Введите конечную станцию маршрута:'
  select_station
  select_end = gets.chomp.to_i
  if select_end > @stations.length || select_end < 1
    puts 'Ошибка! Такой станции нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return create_route
  end
  end_station = @stations[select_end - 1]

  @routes << Route.new(start_station, end_station)

  puts 'Маршрут создан!'
  puts '-----------'
  puts ''
  routes_menu
end

def add_station
  check_routes

  check_stations

  puts 'Выберите маршрут для добавления станции:'
  select_route
  select = gets.chomp.to_i
  if select > @routes.length || select < 1
    puts 'Ошибка! Такого маршрута нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return add_station
  end

  puts 'Укажите название станции:'
  select_station
  new_station = gets.chomp.to_i
  if new_station > @stations.length || new_station < 1
    puts 'Ошибка! Такой станции нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return add_station
  end

  @routes[select - 1].add_station(@stations[new_station - 1])

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
  if select > @routes.length || select < 1
    puts 'Ошибка! Такого маршрута нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return delete_station
  end
  selected_route = @routes[select - 1]

  puts 'Укажите название станции:'
  index = 1
  selected_route.stations.each do |station|
    puts "#{index}. #{station.name}"
    index += 1
  end
  delete_station = gets.chomp.to_i
  if delete_station > selected_route.stations.length || delete_station < 1
    puts 'Ошибка! Такой станции нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return delete_station
  end
  selected_delete_station = selected_route.stations[delete_station - 1]

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
  if selected_route > @routes.length || selected_route < 1
    puts 'Ошибка! Такого маршрута нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return show_stations_in_route
  end

  puts 'Станции выбранного маршрута:'
  @routes[selected_route - 1].stations.each do |station|
    puts station.name
  end

  puts '-----------'
  puts ''
  routes_menu
end

def select_route
  index = 1
  @routes.each do |route|
    puts "#{index}. Маршрут: #{route.stations.first.name} - #{route.stations.last.name}"
    index += 1
  end
end

def show_routes
  puts 'Список маршрутов:'
  select_route
  puts '-----------'
  puts ''
  routes_menu
end

def select_station
  index = 1
  @stations.each do |station|
    puts "#{index}. #{station.name}"
    index += 1
  end
end

# Trains menu and it's routes
def trains_menu
  puts '1. Создать вагон'
  puts '-----------'
  puts '2. Создать поезд'
  puts '3. Назначить маршрут поезду'
  puts '4. Добавить вагон поезду'
  puts '5. Отцепить вагон'
  puts '6. Переместить поезд на следующую станцию'
  puts '7. Переместить поезд на предыдущую станцию'
  puts '-----------'
  puts '0. Вернуться в главное меню'

  select = gets.chomp.to_i
  trains_menu_router(select)
end

def trains_menu_router(select)
  case select
  when 1
    puts '-----------'
    puts ''
    create_wagon
  when 2
    puts '-----------'
    puts ''
    create_train
  when 3
    puts '-----------'
    puts ''
    add_train_route
  when 4
    puts '-----------'
    puts ''
    attach_wagon
  when 5
    puts '-----------'
    puts ''
    unhook_wagon
  when 6
    puts '-----------'
    puts ''
    forward_train
  when 7
    puts '-----------'
    puts ''
    backward_train
  when 0
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

# Trains methods
def select_train
  index = 1
  @trains.each do |train|
    puts "#{index}. Номер поезда: #{train.number}"
    index += 1
  end
end

def select_wagon
  index = 1
  @wagons.each do |wagon|
    puts "#{index}. Тип вагона: #{wagon.type}"
    index += 1
  end
end

def create_wagon
  puts 'Укажите тип вагона. Можно указать Грузовой или Пассажирский:'

  puts '1. Грузовой'
  puts '2. Пассажирский'
  wagon_type = gets.chomp.to_i

  case wagon_type
  when 1..2
    @wagons << Wagon.new('Грузовой') if wagon_type == 1
    @wagons << Wagon.new('Пассажирский') if wagon_type == 2

    puts 'Вагон создан!'
    puts '-----------'
    puts ''
    trains_menu
  else
    puts 'Ошибка! Выберите один из доступных вариантов'
    puts '-----------'
    puts ''
    create_wagon
  end
end

def create_train
  puts 'Укажите тип поезда:'

  puts '1. Грузовой'
  puts '2. Пассажирский'
  select = gets.chomp.to_i

  case select
  when 1
    puts 'Укажите номер поезда:'
    number = gets.chomp.to_i
    @trains << CargoTrain.new(number)
  when 2
    puts 'Укажите номер поезда:'
    number = gets.chomp.to_i
    @trains << PassengerTrain.new(number)
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
end

def add_train_route
  check_trains

  check_routes

  puts 'Выберите поезд для назначения ему маршрута:'
  select_train
  train = gets.chomp.to_i
  if train > @trains.length || train < 1
    puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return add_train_route
  end
  selected_train = @trains[train - 1]

  puts 'Выберите маршрут для назначения его поезду:'
  select_route
  route = gets.chomp.to_i
  if route > @routes.length || route < 1
    puts 'Ошибка! Такого маршрута нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return add_train_route
  end
  selected_route = @routes[route - 1]

  selected_train.add_route(selected_route)

  puts 'Маршрут добавлен!'
  puts '-----------'
  puts ''
  trains_menu
end

def attach_wagon
  check_trains

  check_wagons

  puts 'Выберите поезд для добавления вагона'
  select_train
  train = gets.chomp.to_i
  if train > @trains.length || train < 1
    puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return attach_wagon
  end
  selected_train = @trains[train - 1]

  puts 'Выберите тип вагона для Вашего поезда:'
  select_wagon
  wagon = gets.chomp.to_i
  if wagon > @wagons.length || wagon < 1
    puts 'Ошибка! Такого вагона нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return attach_wagon
  end
  selected_wagon = @wagons[wagon - 1]

  selected_train.add_wagon(selected_wagon)

  puts 'Вагон добавлен!'
  puts '-----------'
  puts ''
  trains_menu
end

def unhook_wagon
  check_trains

  check_wagons

  puts 'Выберите поезд для удаления вагона'
  select_train
  train = gets.chomp.to_i
  if train > @trains.length || train < 1
    puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return unhook_wagon
  end

  @trains[train - 1].delete_wagon

  puts 'Вагон удален!'
  puts '-----------'
  puts ''
  trains_menu
end

def forward_train
  check_trains

  puts 'Выберите поезд для движения к следующей станции:'
  select_train
  train = gets.chomp.to_i
  if train > @trains.length || train < 1
    puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return forward_train
  end

  selected_train = @trains[train - 1]
  if selected_train.route == ''
    puts 'Ошибка! Не назначен маршрут для этого поезда.'
    puts '-----------'
    puts ''
    return trains_menu
  end
  move = selected_train.move_forward

  puts "Поезд прибыл на станцию:  #{move.name}"
  puts '-----------'
  puts ''
  trains_menu
end

def backward_train
  check_trains

  puts 'Выберите поезд для движения к предыдущей станции:'
  select_train
  train = gets.chomp.to_i
  if train > @trains.length || train < 1
    puts 'Ошибка! Такого поезда нет, попробуйте еще раз.'
    puts '-----------'
    puts ''
    return backward_train
  end

  selected_train = @trains[train - 1]
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

# Handling Errors
def check_stations
  if @stations.length < 2
    puts 'Список станций пуст или создана всего одна станция, создайте новую станцию!'
    puts '-----------'
    puts ''
    stations_menu
  end
end

def check_routes
  if @routes.length.zero?
    puts 'Список маршрутов пуст, создайте маршрут!'
    puts '-----------'
    puts ''
    routes_menu
  end
end

def check_trains
  if @trains.length.zero?
    puts 'Список поездов пуст, создайте поезд!'
    puts '-----------'
    puts ''
    trains_menu
  end
end

def check_wagons
  if @trains.length.zero?
    puts 'Список вагонов пуст, создайте вагон!'
    puts '-----------'
    puts ''
    trains_menu
  end
end

main_menu
