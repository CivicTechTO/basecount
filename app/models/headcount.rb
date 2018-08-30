class Headcount < ApplicationRecord
  belongs_to :site
  belongs_to :recorded_by, class_name: "User"
  
  validates :capacity, numericality: { greater_than: 0 }
  validates :occupancy,
    :site,
    :recorded_by,
    :recorded_at,
    :capacity,
    presence: true

  def for_frontend
    {
      id:self.id,
      site: self.site.id,
      recorded_by_id: self.recorded_by_id,
      recorded_at: self.recorded_at,
      capacity: self.capacity,
      occupancy: self.occupancy,
    }
  end

end
