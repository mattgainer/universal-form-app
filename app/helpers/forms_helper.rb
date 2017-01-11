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

  def get_association(key, instance)
    get_foreign_keys(instance).each do |info|
      puts key
      puts info[:foreign_key]
      if info[:foreign_key] == key.to_s
        return info
      end
    end
    return {foreign_key: "No Foreign Key", class_name: "No Class Name", name: "No Name"}
  end
end
