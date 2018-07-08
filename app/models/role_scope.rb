class RoleScope < ApplicationRecord
  belongs_to :user
  belongs_to :role
  belongs_to :org
  belongs_to :shelter
end
