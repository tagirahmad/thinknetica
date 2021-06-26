class Wagon
  include Manufacturer
  include Validator

  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  private

  def validate!
    raise 'Name wagon type not be empty' if @type.empty?
  end
end
