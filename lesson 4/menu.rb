class MenuContainer
  def initialize(stations, trains, routes)
    @stations = stations
    @trains = trains
    @routes = routes
  end

  def run
    menu = <<~MENU
      Choose the action:
      1. Create station
      2. Create train
      3. Create route
      4. Handle route
      5. Handle train
      6. List of all stations and trains
      0. Exit
    MENU

    loop do
      puts menu

      case gets.chomp.to_i
      when 1
        add_station
      when 2
        add_train
      when 3
        add_route
      when 4
        modify_route
      when 5
        modify_train
      when 6
        puts 'List of all stations and trains: '
        @stations.each_with_index do |station, index|
          puts "#{index}. #{station.name}:  #{station.trains.map(&:train_number)}"
        end

        puts "\n"

        @trains.each_with_index do |train, index|
          puts "#{index}. #{train.train_number}"
        end
      when 0
        break
      else
        puts menu
      end
    end
  end

  private

  def add_station
    print 'Write station name: '
    @stations << Station.new(gets.chomp)
  end

  def add_train
    begin
      print 'Write train number: '
      train_number = gets.chomp

      puts <<~MENU
        Choose train type:
        1. Passenger
        2. Cargo
      MENU

      case gets.chomp.to_i
      when 1
        @trains << PassengerTrain.new(train_number)
      when 2
        @trains << CargoTrain.new(train_number)
      else puts 'Wrong type'
      end

      puts "You have created #{@trains.last.train_number}" if @trains.last.valid?
    rescue RuntimeError => e
      puts e.message
      add_train
    end
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
    menu = <<~MENU
      Actions:
      1. Add Station
      2. Delete Station
      0. Exit
    MENU

    loop do
      puts menu
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
      when 0
        break
      else
        puts 'Wrong action'
      end
    end
  end

  def modify_train
    return if @trains.empty? || @routes.empty?

    puts 'Choose train:'
    @trains.each_with_index { |train, index| puts "#{index}. #{train.train_number}" }

    train = @trains[gets.chomp.to_i]
    menu = <<~MENU
      Actions:
      1. Add route
      2. Hitch wagon
      3. Unhitch wagon
      4. Into next station
      5. Into previous station
      0. Exit
    MENU

    loop do
      puts menu
      case gets.chomp.to_i
      when 1
        puts 'Choose route:'
        @routes.each_with_index { |route, index| puts "#{index}. #{route.show_station_names}" }
        route = @routes[gets.chomp.to_i]
        train.accept_route(route)
      when 2
        train.hitch_wagon(Wagon.new(train.type))
      when 3
        train.unhitch_wagon
      when 4
        train.move_forward
      when 5
        train.move_back
      when 0
        break
      else
        puts 'Wrong action'
      end
    end
  end
end
