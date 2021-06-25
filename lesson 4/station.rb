class Station
  include InstanceCounter

  attr_reader :name, :trains

  @stations = []

  class << self
    attr_accessor :stations
  end

  def initialize(name)
    @name = name
    @trains = []
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
end
