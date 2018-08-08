class Site < ApplicationRecord
  belongs_to :org
  has_and_belongs_to_many :aspects
  has_many :schedules
  has_many :schedule_templates
  has_many :rooms
  has_many :roles

  # TODO: need to auto geo-locate based on address
  validates :name,
    :address1,
    :city,
    :postal_code,
    # :lat,
    # :lng,
    presence: true
  
    def users
      self.roles.map do |r|
        {
          user: r.user.format_for_frontend,
          role: r.role
        }
      end
    end
end
