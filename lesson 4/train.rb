# frozen_string_literal: true

class Train
  include Manufacturer
  include InstanceCounter
  include Validator

  REGEXP_NUMBER_PATTERN = /^[\w\d]{3}-?[\w|\d]{2}$/.freeze

  attr_reader :speed, :type, :train_number, :wagons
  attr_writer :wagon

  @@trains = []

  def initialize(train_number)
    @train_number = train_number
    @type = type
    validate!
    @wagons = []
    @speed = 0
    @route = nil
    @@trains << self
    register_instance
  end

  def iterate_over_wagons(&block)
    @wagons.each(&block)
    nil
  end

  def find(train_number)
    @trains.find { |train| train.train_number == train_number }
  end

  def increase_speed(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def hitch_wagon(wagon)
    @wagons << wagon if @speed.zero?
  end

  def unhitch_wagon
    @wagons.pop if @speed.zero?
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

  protected

  def validate!
    raise 'Train number should not be empty' if @train_number.empty?
    raise 'The number does not fit the template' if @train_number !~ REGEXP_NUMBER_PATTERN
  end
end

class PassengerTrain < Train
  def initialize(train_number)
    @train_number = train_number
    @type = :passenger
    super
  end

  def hitch_wagon(wagon)
    super if correct_wagon?(wagon)
  end

  private

  # Method is private because
  # no need to be accessed from outer scope
  # It's a realization, not the interface

  def correct_wagon?(wagon)
    wagon.type == type
  end
end

class CargoTrain < Train
  def initialize(train_number)
    @train_number = train_number
    @type = :cargo
    super
  end

  def hitch_wagon(wagon)
    super if correct_wagon?(wagon)
  end

  private

  # Method is private because
  # no need to be accessed from outer scope
  # It's a realization, not the interface

  def correct_wagon?(wagon)
    wagon.type == type
  end
end
