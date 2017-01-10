class First < ApplicationRecord
  belongs_to :second
  belongs_to :third, class_name: "Third", foreign_key: "third_value"
  FORM_EXCEPTION = ["id"]
end
