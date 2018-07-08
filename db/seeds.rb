# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# orgs
org_dixon_hall = Org.create!(name: 'Dixon Hall', description: 'A description for Dixon Hall', subdomain: 'dixonhall')

# sites

# Heyworth House is an 83-bed co-ed shelter with limited shared accommodation for couples
site_heyworthhouse = Site.create!(
  name: 'Heyworth House',
  org: org_dixon_hall,
  address1: '2714 Danforth Ave.',
  address2: '',
  city: 'Toronto',
  postal_code: 'M4C 1L7',
  description: '',
  lat: 43.689099,
  lng: -79.298233,
)
PopulationWhitelist.create!(site: site_heyworthhouse, code: PopulationWhitelist.codes[:men])
PopulationWhitelist.create!(site: site_heyworthhouse, code: PopulationWhitelist.codes[:women])
Room.create!(site: site_heyworthhouse, capacity: 83)

# Schoolhouse is a 40-bed men's shelter which focuses on the use of the Harm Reduction philosophy.
site_schoolhouse = Site.create!(
  name: 'Schoolhouse',
  org: org_dixon_hall,
  address1: '349 George St.',
  address2: '',
  city: 'Toronto',
  postal_code: 'M5A 2N2',
  description: '',
  lat: 43.660136,
  lng: -79.374273,
)
PopulationWhitelist.create!(site: site_schoolhouse, code: PopulationWhitelist.codes[:men])
Room.create!(site: site_schoolhouse, capacity: 40)