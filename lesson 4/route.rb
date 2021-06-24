class Route
  attr_reader :starting_station

  def initialize(starting_station, end_station)
    @starting_station = starting_station
    @end_station = end_station
    @stations_list = [starting_station, end_station]
  end

  def add_intermediate_station(station)
    @stations_list.insert(-2, station)
  end

  def delete_intermediate_station(station)
    @stations_list.delete(station)
  end

  def show_all_stations
    # [@starting_station, @intermediate_stations, @end_station].flatten!
    @stations_list
  end

  def show_station_names
    @stations_list.map(&:name)
  end
end
