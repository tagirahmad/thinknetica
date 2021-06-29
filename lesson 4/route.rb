# frozen_string_literal: true

# Route class
class Route
  include InstanceCounter
  include Validator

  attr_reader :starting_station

  def initialize(starting_station, end_station)
    @starting_station = starting_station
    @end_station = end_station
    validate!
    @stations_list = [starting_station, end_station]
    register_instance
  end

  def add_intermediate_station(station)
    @stations_list.insert(-2, station)
  end

  def delete_intermediate_station(station)
    @stations_list.delete(station)
  end

  def show_all_stations
    @stations_list
  end

  def show_station_names
    @stations_list.map(&:name)
  end

  protected

  def validate!
    raise 'Starting station should be Station instance' unless @starting_station.is_a? Station
    raise 'End station should Station instance' unless @end_station.is_a? Station
  end
end
