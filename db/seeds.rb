# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

global_dev_password = 'basecount!1234'

# orgs
org_alternate = Org.create!(name: 'Default Org', description: 'A test org', subdomain: 'testorg')
org_dixon_hall = Org.create!(name: 'Dixon Hall', description: 'A description for Dixon Hall', subdomain: 'dixonhall')

# sites

# Heyworth House is an 83-bed co-ed shelter with limited shared accommodation for couples
site_heyworthhouse = Site.create!(
  org: org_dixon_hall,
  name: 'Heyworth House',
  address: '349 George St.',
  postal_code: 'M4C 1L7',
  services: 'Example services for Heyworth House',
  populations: [1,2],
  phone: '416-691-0012',
  default_capacity: 83,
)

# Schoolhouse is a 40-bed men's shelter which focuses on the use of the Harm Reduction philosophy.
site_schoolhouse = Site.create!(
  org: org_dixon_hall,
  name: 'Schoolhouse',
  address: '2714 Danforth Ave, Toronto, ON',
  postal_code: 'M5A 2N2',
  services: 'Example services for Schoolhouse',
  populations: [2],
  phone: '416-960-9240',
  default_capacity: 40,
)

# create users
user_heyworth_manager = User.create!(
  first_name: 'Heyworth',
  last_name: 'Manager',
  email: 'heyworthmanager@basecount.ca',
  password: global_dev_password,
)
Role.grant_user_role(user_heyworth_manager, :site_manager, site_heyworthhouse)

user_heyworth_employee = User.create!(
  first_name: 'Heyworth',
  last_name: 'Employee',
  email: 'heyworthemployee@basecount.ca',
  password: global_dev_password,
)
Role.grant_user_role(user_heyworth_employee, :site_employee, site_heyworthhouse)

user_dixonhall_employee = User.create!(
  first_name: 'DixonHall',
  last_name: 'Employee',
  email: 'dixonhallemployee@basecount.ca',
  password: global_dev_password,
)
Role.grant_user_role(user_dixonhall_employee, :org_employee, org_dixon_hall)

user_dixonhall_manager = User.create!(
  first_name: 'DixonHall',
  last_name: 'Manager',
  email: 'dixonhallmanager@basecount.ca',
  password: global_dev_password,
)
Role.grant_user_role(user_dixonhall_manager, :org_manager, org_dixon_hall)

user_global_admin = User.create!(
  first_name: 'Global',
  last_name: 'Admin',
  email: 'globaladmin@basecount.ca',
  password: global_dev_password,
)
Role.grant_user_role(user_global_admin, :global_admin)

user_global_dataviewer = User.create!(
  first_name: 'Global',
  last_name: 'Dataviewer',
  email: 'globaldataviewer@basecount.ca',
  password: global_dev_password,
)
Role.grant_user_role(user_global_dataviewer, :global_dataviewer)

Headcount.create!(
  recorded_by: user_heyworth_employee,
  site: site_heyworthhouse,
  occupancy: 75,
  recorded_at: Time.now,
  capacity: 83
)