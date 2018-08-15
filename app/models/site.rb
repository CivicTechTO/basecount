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


  def self.new_from_frontend ( frontend_hash )
    create_arguments = frontend_hash[:general].merge(frontend_hash[:services])

    # now convert array to pretty
    puts create_arguments
    self.new(create_arguments)
  end


  @@population_codes = [
    { id: :women, pretty: "Women" },
    { id: :men, pretty: "Men" },
    { id: :children, pretty: "Children" },
    { id: :youth, pretty: "Youth" },
    { id: :trans, pretty: "Trans" },
  ]
  



  def populations
    self[:populations].map.with_index do |v,i|
      @@population_codes[i]
    end
  end

  # When setting, it should set by an array of codes
  def populations=(array_of_codes)
    self[:populations] = array_of_codes.map do |code|
      @@population_codes.find { |pc| pc[:code] == code }
    end
  end


  def users
    self.roles.map do |r|
      {
        user: r.user.format_for_frontend,
        role: r.role
      }
    end
  end


  def extra_info
    {
      general: {
        name: self.name,
        address: self.address,
        postal_code: self.postal_code,
        phone: self.phone,
      },
      services: {
        service_text: self.services,
        populations_served: self.populations
      },
      schedule: {
        status: "Not yet implemented"
      }
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
