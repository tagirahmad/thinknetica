# frozen_string_literal: true

# Checks if entity is valid or not by calling implicitly passed validate! function
module Validator
  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end
end

# Helps to validate fields
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # ClassMethods
  module ClassMethods
    attr_accessor :validators

    def all_validators(name, type, comparable)
      @validators ||= []
      @validators << { name: name,
                       validation_type: type,
                       comparable: comparable }
    end

    def validate(attr, *args)
      name = "@#{attr}".to_sym
      type = args[0].to_s.sub(':', '')
      comparable = args[1]
      all_validators(name, type, comparable)
    end
  end

  # InstanceMethods
  module InstanceMethods
    def validate!
      self.class.instance_variable_get(:@validators).each do |elem|
        send "validate_#{elem[:validation_type]}".to_sym, elem[:name], elem[:comparable]
      end
    end

    def validate_presence(value, _)
      var = instance_variable_get(value)
      return unless var == '' || var.nil?

      raise ArgumentError, 'Validate_presence: Argument is empty!'
    end

    def validate_format(value, args)
      return unless instance_variable_get(value) !~ args

      raise ArgumentError, 'Validate_format: Wrong format of argument!'
    end

    def validate_type(value, args)
      return if instance_variable_get(value).instance_of? args

      raise ArgumentError, 'Validate_type: Different types!'
    end

    def valid?
      validate!
      true
    rescue ArgumentError
      false
    end
  end
end
