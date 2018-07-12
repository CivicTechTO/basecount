class Room < ApplicationRecord
  belongs_to :site
  has_many :historical_capacities
end
