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
