class Station
  include InstanceCounter
  include Validator

  attr_reader :name, :trains

  @stations = []

  class << self
    attr_accessor :stations
  end

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

  def iterate_over_trains
    @trains.each do |train|
      yield(train)
    end
    nil
  end

  protected

  def validate!
    raise 'Station name should not be empty' if @name.empty?
    raise 'Station should not be less that 5 charachters' if @name.size < 5
  end
end
