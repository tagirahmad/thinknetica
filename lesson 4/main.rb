require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'menu'
require_relative 'wagon'

stations = []
stations << Station.new('Station 1')
stations << Station.new('Station 2')
stations << Station.new('Station 3')
stations << Station.new('Station 4')
stations << Station.new('Station 5')
stations << Station.new('Station 6')
stations << Station.new('Station 7')
stations << Station.new('Station 8')

route = Route.new(stations[0], stations[-1])

train = PassengerTrain.new('Pass1')
train2 = CargoTrain.new('998')

train.accept_route(route)

menu = MenuContainer.new(stations, [train, train2], [route])
menu.run