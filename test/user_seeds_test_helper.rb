require 'faker'

class UserSeedsTestHelper
  def self.clean
    User.destroy_all
  end

  def self.seed_all_users
    User.destroy_all
    {
      user_site1_volunteer: create_random_user,
      user_site1_employee: create_random_user,
      user_site1_manager: create_random_user,
      user_site2_volunteer: create_random_user,
      user_site2_employee: create_random_user,
      user_site2_manager: create_random_user,
      user_org_employee: create_random_user,
      user_org_manager: create_random_user,
      user_global_admin: create_random_user,
      user_global_dataviewer: create_random_user,
      user_global_loggedin: create_random_user,
    }
  end

  def self.seed_user
    create_random_user
  end
  
  def self.create_random_user
    User.create!(generate_random_user_params)
  end

  def self.generate_random_user_params
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.unique.email,
      password: Faker::String.random(8)
    }
  end

  private_class_method :create_random_user
  private_class_method :generate_random_user_params
end
