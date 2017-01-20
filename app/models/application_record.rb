class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # Returns array of strings of column names that don't get fields in the forms, defaulted to Rails
  ## default primary key field and default timestamps
  # 
  def self.form_exception 
    return ["id", "created_at", "updated_at"]
  end
  # Exposes form_selectable class method that 
  def self.form_selectable
    return all
  end
  def self.check_exception(key)
    return !form_exception.include?(key)
  end

  def self.form_select_text
    return new.attributes.keys[1]
  end
  
  def self.generate_new_instance(params)
    instance = new
    input_hash = {}
    params = params[instance.class.to_s.downcase]
    (instance.attributes.keys.map {|k| k.to_sym}).each do |key|
      if ["date", :date].include?(instance.column_for_attribute(key).type)
        year = params[key.to_s + "(1i)"].to_i
        month = params[key.to_s + "(2i)"].to_i
        day = params[key.to_s + "(3i)"].to_i
        input_hash[key] = Date.new(year, month, day)
      elsif ["time", :time].include?(instance.column_for_attribute(key).type)
        hour = params[key.to_s + "(4i)"].to_i
        minute = params[key.to_s + "(5i)"].to_i
        input_hash[key] = "#{hour}:#{minute}"
      elsif ["datetime", :datetime].include?(instance.column_for_attribute(key).type)
        year = params[key.to_s + "(1i)"].to_i
        month = params[key.to_s + "(2i)"].to_i
        day = params[key.to_s + "(3i)"].to_i
        hour = params[key.to_s + "(4i)"].to_i
        minute = params[key.to_s + "(5i)"].to_i
        input_hash[key] = DateTime.new(year, month, day, hour, minute)
      else
        input_hash[key] = params[key]
      end
    end
    instance.attributes = input_hash
    return instance
  end

  def self.get_foreign_keys
    keys = []
    reflect_on_all_associations.each do |a|
      keys << {foreign_key: a.foreign_key, class_name: a.class_name, name: a.name}
    end
    return keys    
  end
  def self.get_association(key)
    get_foreign_keys.each do |info|
      if info[:foreign_key] == key.to_s
        return info
      end
    end
    return {foreign_key: "No Foreign Key", class_name: "No Class Name", name: "No Name"}
  end
end
