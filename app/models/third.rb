class Third < ApplicationRecord
  has_many :firsts
  FORM_EXCEPTION = ["id", "created_at"]
end
