# frozen_string_literal: true

require 'byebug'

require_relative 'validator'
require_relative 'instance_counter'
require_relative 'consts'
require_relative 'manufacturer'
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

train = PassengerTrain.new('Pas-11')
wagon1 = PassengerWagon.new(20)
wagon1.reserve
train.hitch_wagon wagon1
train.hitch_wagon wagon1
train2 = CargoTrain.new('998tr')
wagon2 = CargoWagon.new(200)
wagon2.reserve
train2.hitch_wagon wagon2
train2.hitch_wagon wagon2
train2.hitch_wagon wagon2

train.accept_route(route)
train2.accept_route(route)

menu = MenuContainer.new(stations, [train, train2], [route])
menu.run
