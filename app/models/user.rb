class User < ApplicationRecord
  include UserPermissionsHelper
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :roles

  def has_role?(role, site_or_org = nil)
    Role.user_has_role?(self,role,site_or_org)
  end

  def format_for_frontend
    acceptable_frontend_keys = [
      "first_name",
      "last_name",
      "email",
      "id"
    ]

    # TODO: need to add permissions

    frontend_value = {}
    self_json = self.as_json
    acceptable_frontend_keys.each do |k|
      frontend_value[k] = self_json[k]
    end

    frontend_value
  end
end
