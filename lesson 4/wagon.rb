# frozen_string_literal: true

# Base wagon class
class Wagon
  include Manufacturer
  include Validator

  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  def reserved
    raise NotImplementedError, 'You must implement #reserved.'
  end

  def reserve
    raise NotImplementedError, 'You must implement #reserve.'
  end

  def free
    raise NotImplementedError, 'You must implement #free.'
  end

  private

  def validate!
    raise 'Name wagon type not be empty' if @type.empty?
  end
end

# Child class of Wagon
class PassengerWagon < Wagon
  attr_reader :reserved_seats, :seats_number

  def initialize(seats_number)
    @type = :passenger
    @seats_number = seats_number
    @reserved_seats = 0
    super(@type)
  end

  def reserved
    @reserved_seats
  end

  def reserve
    reserve_seat
  end

  def free
    free_places
  end

  private

  def reserve_seat
    @reserved_seats += 1 unless @reserved_seats >= @seats_number
  end

  def free_places
    @seats_number - @reserved_seats
  end
end

# Child class of Wagon
class CargoWagon < Wagon
  attr_reader :reserved_volume, :volume

  def initialize(volume)
    @type = :cargo
    @volume = volume
    @reserved_volume = 0
    super(@type)
  end

  def reserved
    @reserved_volume
  end

  def reserve
    reserve_volume
  end

  def free
    free_volume
  end

  private

  def reserve_volume
    @reserved_volume += 1 unless @reserved_volume >= @volume
  end

  def free_volume
    @volume - @reserved_volume
  end
end
