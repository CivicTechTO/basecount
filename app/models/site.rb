class Site < ApplicationRecord
  belongs_to :org
  has_and_belongs_to_many :aspects
  has_many :schedules
  has_many :schedule_templates
  has_many :rooms

  validates :name,
    :address1,
    :city,
    :postal_code,
    :lat,
    :lng,
    presence: true
end
