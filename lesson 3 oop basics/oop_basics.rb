class Station
  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    @trains << train
  end

  def show_train_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end

class Route
  attr_reader :starting_station

  def initialize(starting_station, end_station)
    @starting_station = starting_station
    @end_station = end_station
    @intermediate_stations = []
  end

  def add_intermediate_station(station)
    @intermediate_stations << station
  end

  def delete_intermediate_station(station)
    @intermediate_stations.delete(station)
  end

  def show_all_stations
    [@starting_station, @intermediate_stations, @end_station].flatten!
  end
end

class Train
  attr_reader :speed, :wagon_count, :type

  def initialize(train_number, type, wagon_count)
    @train_number = train_number
    @type = type
    @wagon_count = wagon_count
    @speed = 0
    @route = nil
  end

  def increase_speed(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def hitch_wagon
    @wagon_count += 1 if @speed.zero?
  end

  def unhitch_wagon
    @wagon_count -= 1 if @speed.zero?
  end

  def accept_route(route)
    @route = route
    @route.starting_station.accept_train(self)
    @station_index = 0
  end

  def current_station
    @route.show_all_stations[@station_index]
  end

  def next_station
    return unless @route

    @route.show_all_stations[@station_index + 1]
  end

  def previous_station
    return unless @route
    return if @station_index < 1

    @route.show_all_stations[@station_index - 1]
  end

  def move_forward
    return unless @route && next_station

    current_station.send_train(self)
    @station_index += 1
    current_station.accept_train(self)
  end

  def move_back
    return unless @route && previous_station

    current_station.send_train(self)
    @station_index -= 1
    current_station.accept_train(self)
  end
end

route1 = Route.new(Station.new('station 1'), Station.new('station 2'))
intermediate_station = Station.new('Intermediate station')
route1.add_intermediate_station(intermediate_station)
route1.delete_intermediate_station(intermediate_station)
# p route1.show_all_stations
train = Train.new('10', 'type1', 3)
train.accept_route(route1)
train.move_forward
p route1.show_all_stations
