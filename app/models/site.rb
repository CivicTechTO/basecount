class Site < ApplicationRecord
  belongs_to :org
  has_and_belongs_to_many :aspects
  has_many :schedules
  has_many :schedule_templates
  has_many :rooms
  has_many :roles

  serialize :populations, Array

  # TODO: will need to pull in "active" for later
  validates :name,
  :address,
  :postal_code,
  :phone,
  presence: true

  def self.convert_attrs_from_frontend_hash ( frontend_hash )
    frontend_hash[:general].merge(frontend_hash[:services])
  end

  def self.new_from_frontend ( frontend_hash )
    self.new(self.convert_attrs_from_frontend_hash ( frontend_hash ) )
  end

  def update_from_frontend ( frontend_hash )
    self.update(Site.convert_attrs_from_frontend_hash ( frontend_hash ) )
  end



  @@population_codes = [
    { id: 1, display: "Women" },
    { id: 2, display: "Men" },
    { id: 3, display: "Children" },
    { id: 4, display: "Youth" },
    { id: 5, display: "Trans" },
  ]

  def populations
    self[:populations].map do |pop_id|
      @@population_codes.find{ |popcode| popcode[:id] == pop_id }
    end
  end

  # When setting, it should set by an array of IDs
  def populations=(array_of_ids)
    self[:populations] = array_of_ids
  end


  def users
    self.roles.map do |r|
      {
        user: r.user.format_for_frontend,
        role: r.role
      }
    end
  end


  def to_frontend
    {
      general: {
        org_id: self.org_id,
        name: self.name,
        address: self.address,
        postal_code: self.postal_code,
        phone: self.phone,
      },
      services: {
        services: self.services,
        populations: self.populations
      },
      # schedule: {
      #   status: "Not yet implemented"
      # }
    }
  end

  # Not yet in use
  # def save_aspects! aspects_array
  #   aspects_array.each do |aspect|
  #     self.aspects << aspect unless self.aspects.include? aspect
  #   end
  #   self.save!
  # end

end
