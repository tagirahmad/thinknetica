# frozen_string_literal: true

# Station class
class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  @stations = []

  class << self
    attr_accessor :stations
  end

  validate :name, :presence

  def initialize(name)
    @name = name
    @trains = []
    validate!
    self.class.stations << self
    register_instance
  end

  def self.all
    @stations
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

  def iterate_over_trains(&block)
    @trains.each(&block)
    nil
  end
end
