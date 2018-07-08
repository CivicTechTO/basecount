class Room < ApplicationRecord
  belongs_to :shelter
  has_many :historical_capacities
end
