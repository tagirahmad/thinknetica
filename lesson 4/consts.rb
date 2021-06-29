# frozen_string_literal: true

module Consts
  MENU = <<~MENU
    Choose the action:
    1. Create station
    2. Create train
    3. Create route
    4. Handle route
    5. Handle train
    6. List of all stations and trains
    0. Exit
  MENU

  CHOOSE_TRAIN = <<~MENU
    Choose train type:
    1. Passenger
    2. Cargo
  MENU

  STATION_ACTIONS = <<~MENU
    Actions:
    1. Add Station
    2. Delete Station
    0. Exit
  MENU

  TRAIN_ACTION = <<~MENU
    Actions:
    1. Add route
    2. Hitch wagon
    3. Unhitch wagon
    4. Into next station
    5. Into previous station
    0. Exit
  MENU
end
