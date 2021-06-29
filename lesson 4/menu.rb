# frozen_string_literal: true

class MenuContainer
  include Consts

  def initialize(stations, trains, routes)
    @stations = stations
    @trains = trains
    @routes = routes
  end

  def run
    loop do
      puts MENU

      case gets.chomp.to_i
      when 1 then add_station
      when 2 then add_train
      when 3 then add_route
      when 4 then modify_route
      when 5 then modify_train
      when 6
        puts 'List of all stations and trains: '
        @stations.each_with_index do |station, index|
          puts <<~STATIONS
            #{index}. #{station.name}:#{'  '}
            #{station.trains.map { |t| "#{t.train_number} - #{t.wagons.length} wagons count - #{t.type} type" }}
            #{station.trains.map { |t| "Train #{t.train_number} #{t.wagons.map { |w| "#{w.type} wagon (#{w.reserved} reserved; #{w.free} free)" }}" }}
          STATIONS
        end

        puts "\n"

        @trains.each_with_index do |train, index|
          puts "#{index}. #{train.train_number}"
        end
      when 0 then break
      else puts menu
      end
    end
  end

  private

  def add_station
    print 'Write station name: '
    @stations << Station.new(gets.chomp)
  end

  def add_train
    print 'Write train number: '
    train_number = gets.chomp

    puts CHOOSE_TRAIN

    case gets.chomp.to_i
    when 1 then @trains << PassengerTrain.new(train_number)
    when 2 then @trains << CargoTrain.new(train_number)
    else puts 'Wrong type'
    end

    puts "You have created #{@trains.last.train_number}" if @trains.last.valid?
  rescue RuntimeError => e
    puts e.message
    add_train
  end

  def add_route
    return if @stations.size <= 1

    puts 'Choose starting station:'
    @stations.each_with_index { |station, index| puts "#{index}. #{station.name}" }
    starting_station = @stations[gets.chomp.to_i]

    puts 'Choose ending station:'
    @stations.each_with_index { |station, index| puts "#{index}. #{station.name}" }
    ending_station = @stations[gets.chomp.to_i]

    @routes << Route.new(starting_station, ending_station)
  end

  def modify_route
    return if @routes.empty?

    puts 'Choose the route:'
    @routes.each_with_index { |route, index| puts "#{index}. #{route.show_station_names}" }

    route = @routes[gets.chomp.to_i]

    loop do
      puts STATION_ACTIONS
      case gets.chomp.to_i
      when 1
        puts 'Choose stantion:'
        @stations.each_with_index { |station, index| puts "#{index}. #{station.name}" }
        route.add_intermediate_station(@stations[gets.chomp.to_i])
      when 2
        puts 'Choose stantion:'
        route.show_all_stations.each_with_index { |station, index| puts "#{index}. #{station.name}" }
        station = route.show_all_stations[gets.chomp.to_i]
        route.delete_intermediate_station(station)
      when 0 then break
      else puts 'Wrong action'
      end
    end
  end

  def modify_train
    return if @trains.empty? || @routes.empty?

    puts 'Choose train:'
    @trains.each_with_index { |train, index| puts "#{index}. #{train.train_number}" }

    train = @trains[gets.chomp.to_i]

    loop do
      puts TRAIN_ACTION
      case gets.chomp.to_i
      when 1
        puts 'Choose route:'
        @routes.each_with_index { |route, index| puts "#{index}. #{route.show_station_names}" }
        route = @routes[gets.chomp.to_i]
        train.accept_route(route)
      when 2 then train.hitch_wagon(Wagon.new(train.type))
      when 3 then train.unhitch_wagon
      when 4 then train.move_forward
      when 5 then train.move_back
      when 0 then break
      else puts 'Wrong action'
      end
    end
  end
end
