require 'faker'
require 'global_err'

class SiteOrgSeedsTestHelper
  def self.clean
    Org.destroy_all
    Site.destroy_all
  end

  def self.seed_site (org)
    raise GlobalErr::ERRORS[:required_param] if org.nil?
    Site.create!(generate_random_site_params(org))
  end

  def self.seed_org
    Org.create!(generate_random_org_params)
  end
  
  # TODO: faker
  def self.generate_random_org_params
    {
      name: "Dixon Hall #{rand(10000)}",
      description: "A description for Dixon Hall #{rand(10000)}",
      subdomain: "dixonhall#{rand(10000)}"
    }
  end

  # TODO: faker
  def self.generate_random_site_params(org)
    {
      name: "Heyworth House#{rand(10000)}",
      org: org,
      address1: Faker::Address.street_address,
      address2: '',
      city: 'Toronto',
      postal_code: 'M4C 1L7',
      description: '',
      lat: Faker::Address.latitude,
      lng: Faker::Address.longitude,
    }
  end

  private_class_method :generate_random_site_params
  private_class_method :generate_random_org_params
end
