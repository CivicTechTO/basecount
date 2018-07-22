class Headcount < ApplicationRecord
  belongs_to :room
  belongs_to :recorded_by, class_name: "User"
  
  # TODO: Validations
end
