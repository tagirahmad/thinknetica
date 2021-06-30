# frozen_string_literal: true

# Route class
class Route
  include InstanceCounter
  include Validation

  attr_reader :starting_station

  validate :starting_station, :presence
  validate :end_station, :presence
  validate :starting_station, :type, Station
  validate :end_station, :type, Station

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
end
