class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # Instance method that updates a record based on the values passed in from the form to the controller.
  ## Parses the date and time fields correctly, which doesn't happen out of the box.
  def update_this_instance(params)
    params_hash = {}
    instance_parameters = params[self.class.to_s.downcase]
    (attributes.keys.map {|k| k.to_sym}).each do |key|
      if self.class.check_exception(key.to_s)
        if ["date", :date].include?(column_for_attribute(key).type)
          year = instance_parameters[key.to_s + "(1i)"].to_i
          month = instance_parameters[key.to_s + "(2i)"].to_i
          day = instance_parameters[key.to_s + "(3i)"].to_i
          params_hash[key] = Date.new(year, month, day)
        elsif ["datetime", :datetime, "time", :time].include?(column_for_attribute(key).type)
          year = instance_parameters[key.to_s + "(1i)"].to_i
          month = instance_parameters[key.to_s + "(2i)"].to_i
          day = instance_parameters[key.to_s + "(3i)"].to_i
          hour = instance_parameters[key.to_s + "(4i)"].to_i
          minute = instance_parameters[key.to_s + "(5i)"].to_i
          input_hash[key] = DateTime.new(year, month, day, hour, minute)
        else
          params_hash[key] = instance_parameters[key]
        end
      end
    end
    self.attributes = params_hash
    return self.save
  end
  # Returns array of strings of column names that don't get fields in the forms, defaulted to Rails
  ## default primary key field and timestamps
  #
  def self.form_exception
    return ["id", "created_at", "updated_at"]
  end
  # Checks a key against the attributes in the form_exception list. If the key is in the list, it returns
  ## false and the key is not shown on the form
  def self.check_exception(key)
    return !form_exception.include?(key)
  end
  # Exposes form_selectable class method that limits which records can be selected from the drop-down menus
  ## when using collection_selects in associations
  def self.form_selectable
    return all
  end
  # Choses which field is the displayed text in collection selects using records from this model.
  ## Defaults to the first non-id attribute.
  def self.form_select_text
    return new.attributes.keys[1]
  end
  # method to replace new when using date, time, and datetime field types in the form. This method parses
  ## the fields in the rails date/time form helpers into values that can be stored by the database.
  def self.generate_new_instance(params)
    instance = new
    input_hash = {}
    instance_parameters = params[instance.class.to_s.downcase]
    (instance.attributes.keys.map {|k| k.to_sym}).each do |key|
      if check_exception(key.to_s)
        if ["date", :date].include?(instance.column_for_attribute(key).type)
          year = instance_parameters[key.to_s + "(1i)"].to_i
          month = instance_parameters[key.to_s + "(2i)"].to_i
          day = instance_parameters[key.to_s + "(3i)"].to_i
          input_hash[key] = Date.new(year, month, day)
        elsif ["datetime", :datetime, "time", :time].include?(instance.column_for_attribute(key).type)
          year = instance_parameters[key.to_s + "(1i)"].to_i
          month = instance_parameters[key.to_s + "(2i)"].to_i
          day = instance_parameters[key.to_s + "(3i)"].to_i
          hour = instance_parameters[key.to_s + "(4i)"].to_i
          minute = instance_parameters[key.to_s + "(5i)"].to_i
          input_hash[key] = DateTime.new(year, month, day, hour, minute)
        else
          input_hash[key] = instance_parameters[key]
        end
      end
    end
    instance.attributes = input_hash
    return instance
  end
  # This method returns the list of foreign keys within a model. This is used when determining
  ## when a collection_select should be used to display an association
  def self.get_foreign_keys
    keys = []
    reflect_on_all_associations.each do |a|
      keys << {foreign_key: a.foreign_key, class_name: a.class_name, name: a.name}
    end
    return keys
  end
  # Method that checks the get_foreign_keys method against a specific key to determine
  ## whether or not a key needs a collection_select in the form, due to being part of an association.
  def self.get_association(key)
    get_foreign_keys.each do |info|
      if info[:foreign_key] == key.to_s
        return info
      end
    end
    return {foreign_key: "No Foreign Key", class_name: "No Class Name", name: "No Name"}
  end
  # Method to check whether a field should be required by the form. Does not check any other validation type other than presence: true
  def self.check_required_validations(attribute)
    validators.each do |validator|
      if validator.attributes.include?(attribute) && validator.class == ActiveRecord::Validations::PresenceValidator
        return true
      end
    end
    return false
  end
end
