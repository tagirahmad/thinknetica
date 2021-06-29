# frozen_string_literal: true

# Counts number of class instances
module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  # Class methods for class which includes InstanceCounter
  module ClassMethods
    attr_accessor :count

    def self.instances
      self.count ||= 0
    end

    def increase_count
      self.count ||= 0
      self.count += 1
    end
  end

  # Instance methods for class which includes InstanceCounter
  module InstanceMethods
    protected

    def register_instance
      self.class.increase_count
    end
  end
end
