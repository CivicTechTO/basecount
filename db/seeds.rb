# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ROLES
role_site_volunteer = Role.create!(name: 'Site Volunteer', code: 'site_volunteer')
role_site_employee = Role.create!(name: 'Site Employee', code: 'site_employee')
role_site_manager = Role.create!(name: 'Site Manager', code: 'site_manager')
role_org_employee = Role.create!(name: 'Org Employee', code: 'org_employee')
role_org_manager = Role.create!(name: 'Org Manager', code: 'org_manager')
role_global_admin = Role.create!(name: 'Global Admin', code: 'global_admin')
role_global_dataviewer = Role.create!(name: 'Respite Data Viewer', code: 'global_dataviewer')
role_global_loggedout = Role.create!(name: 'Logged-out user', code: 'global_loggedout')
role_global_loggedin = Role.create!(name: 'Logged-in user', code: 'global_loggedin')

# PERMISSIONS
permission_global_view_site_details = Permission.create!(code: 'global_view_site_details', description: 'Can see respite address, schedules, and other basic information')
permission_global_view_counts = Permission.create!(code: 'global_view_counts', description: 'Can view headcounts at respite sites')
permission_global_manage_orgs = Permission.create!(code: 'global_manage_orgs', description: 'Add, remove, or edit orgs')
permission_global_manage_users = Permission.create!(code: 'global_manage_users', description: 'Add, remove, or edit all users')
permission_org_manage_users = Permission.create!(code: 'org_manage_users', description: 'Add, remove, or edit users for a given org')
permission_org_manage_site_managers = Permission.create!(code: 'org_manage_site_managers', description: 'Add, remove, or edit managers for a given site')
permission_org_manage_sites = Permission.create!(code: 'org_manage_sites', description: 'Add, remove, or edit sites or site schedules for a given org')
permission_org_view_historical = Permission.create!(code: 'org_view_historical', description: 'View & run reports on historical occupancy for all sites in an org')
permission_site_manage_users = Permission.create!(code: 'site_manage_users', description: 'Add, remove, or edit employees & volunteers for a given site')
permission_site_manage_site = Permission.create!(code: 'site_manage_site', description: 'Add, remove, or edit a given site or site schedule')
permission_site_add_counts = Permission.create!(code: 'site_add_counts', description: 'Add headcounts for a given site')
permission_site_view_historical = Permission.create!(code: 'site_view_historical', description: 'View & run reports on historical occupancy for a given site')
permission_site_edit_calendar = Permission.create!(code: 'site_edit_calendar', description: 'Edit an availability calendar for a site')

# ROLE PERMISSIONS
permission_global_view_site_details.roles << role_global_loggedin
permission_global_view_site_details.save!

permission_global_view_counts.roles << role_global_dataviewer
permission_global_view_counts.save!

permission_global_view_counts.roles << role_global_admin
permission_global_view_counts.save!

permission_global_manage_orgs.roles << role_global_admin
permission_global_manage_orgs.save!

permission_global_manage_users.roles << role_global_admin
permission_global_manage_users.save!

permission_org_manage_users.roles << role_org_manager
permission_org_manage_users.save!

permission_org_manage_site_managers.roles << role_org_manager
permission_org_manage_site_managers.save!

permission_org_manage_sites.roles << role_org_employee
permission_org_manage_sites.save!

permission_org_view_historical.roles << role_org_employee
permission_org_view_historical.save!

permission_site_manage_users.roles << role_site_manager
permission_site_manage_users.save!

permission_site_manage_site.roles << role_site_manager
permission_site_manage_site.save!

permission_site_add_counts.roles << role_site_volunteer
permission_site_add_counts.save!

permission_site_view_historical.roles << role_site_volunteer
permission_site_view_historical.save!

# orgs
org_dixon_hall = Org.create!(name: 'Dixon Hall', description: 'A description for Dixon Hall', subdomain: 'dixonhall')

# shelters

# Heyworth House is an 83-bed co-ed shelter with limited shared accommodation for couples
shelter_heyworthhouse = Shelter.create!(
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
PopulationWhitelist.create!(shelter: shelter_heyworthhouse, code: PopulationWhitelist.codes[:men])
PopulationWhitelist.create!(shelter: shelter_heyworthhouse, code: PopulationWhitelist.codes[:women])
Room.create!(shelter: shelter_heyworthhouse, capacity: 83)

# Schoolhouse is a 40-bed men's shelter which focuses on the use of the Harm Reduction philosophy.
shelter_schoolhouse = Shelter.create!(
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
PopulationWhitelist.create!(shelter: shelter_schoolhouse, code: PopulationWhitelist.codes[:men])
Room.create!(shelter: shelter_schoolhouse, capacity: 40)