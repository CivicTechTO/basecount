class Headcount < ApplicationRecord
  belongs_to :room
  belongs_to :recorded_by, class_name: "User"
  
  validates :capacity, numericality: { greater_than: 0 }
  validates :occupancy,
    :room,
    :recorded_by,
    :recorded_at,
    :capacity,
    presence: true

end
