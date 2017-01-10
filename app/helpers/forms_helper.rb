module FormsHelper
  def check_exception(key, instance)
    check  = instance.class::FORM_EXCEPTION
    return !check.include?(key)
  end

  def get_foreign_keys(instance)
    keys = []
    instance.class.reflect_on_all_associations.each do |a|
      keys << {foreign_key: a.foreign_key, class_name: a.class_name, name: a.name}
    end
    return keys
  end

  def generate_new_instance(params, instance)
    input_hash = {}
    (instance.attributes.keys.map {|k| k.to_sym}).each do |key|
      if ["date", :date].includes?(instance.column_for_attribute(key).type)
        year = params[key.to_s + "(i1)"]
        month = params[key.to_s + "(i2)"]
        day = params[key.to_s + "(i3)"]
        input_hash[key] = Date.new(year, month, day)
      elsif ["time", :time].includes?(instance.column_for_attribute(key).type)
        hour = params[key.to_s + "(i4)"]
        minute = params[key.to_s + "(i5)"]
      elsif ["datetime", :datetime].includes?(instance.column_for_attribute(key).type)
        
      else
        input_hash[key] = params[key]
      end
    end
    return instance.attributes(input_hash)
  end
end
