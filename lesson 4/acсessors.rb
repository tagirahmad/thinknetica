# Can be called from Class level. creates attr_accessors with history
module Accessors
  def attr_accessor_with_history(*args)
    history_arr = []
    args.each do |arg|
      var_name = "@#{arg}".to_sym
      history_var_name = "@#{name}_history".to_sym
      define_method(arg) { instance_variable_get(var_name) }
      define_method("#{name}_history".to_sym) { instance_variable_get(history_var_name) }
      define_method("#{arg}=".to_sym) do |value|
        instance_variable_set(history_var_name, history_arr << instance_variable_get(var_name))
        instance_variable_set(var_name, value)
      end
    end
  end

  def strong_attr_accessor(name, its_class)
    var_name = "@#{name}".to_sym
    define_method(name.to_sym) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      if value.instance_of?(its_class)
        instance_variable_set(var_name, value)
      else
        raise ArgumentError, "Passed value type doesn't match"
      end
    end
  end
end
