require 'global_err'

class Role < ApplicationRecord

  belongs_to :user
  belongs_to :org, optional: true
  belongs_to :site, optional: true

  enum role: [
    :site_employee,
    :site_manager,
    :org_employee,
    :org_manager,
    :global_admin,
    :global_dataviewer,
  ]

  GLOBAL_ROLES = [
    :global_admin,
    :global_dataviewer,
  ]

  SITE_ROLES = [
    :site_employee,
    :site_manager,
  ]

  ORG_ROLES = [
    :org_employee,
    :org_manager,
  ]

  def self.grant_user_role ( user, role, site_or_org = nil )
    self.validate_user_role_scope( user, role, site_or_org )

    # does user have role already?
    return user if self.user_has_role?(user, role, site_or_org)

    role_hash = {
      role: role,
      user: user
    }

    # Apply the site or org appropriately
    unless site_or_org.nil?
      if SITE_ROLES.include? role
        role_hash[:site] = site_or_org
      elsif ORG_ROLES.include? role
        role_hash[:org] = site_or_org
      end
    end

    user.roles << Role.new(role_hash)

    user
  end

  def self.user_has_role? ( user, role, site_or_org = nil )
    self.validate_user_role_scope( user, role, site_or_org )
    role_string = role.to_s

    return false if user.roles.empty?

    applicable_roles = user.roles.select do |s|
      if GLOBAL_ROLES.include? role
        s.role == role_string
      elsif ORG_ROLES.include? role
        s.role == role_string and s.org == site_or_org
      elsif SITE_ROLES.include? role
        s.role == role_string and s.site == site_or_org
      end
    end


    applicable_roles.length > 0
  end

  def self.validate_user_role_scope( user, role, site_or_org )
    raise GlobalErr::ERRORS[:invalid_role] unless Role.roles.include? role
    raise GlobalErr::ERRORS[:invalid_user] unless user.class == User
    raise GlobalErr::ERRORS[:site_org_set] if (
      site_or_org.nil? and
      ! GLOBAL_ROLES.include? role
    )
    raise GlobalErr::ERRORS[:must_be_org] if ORG_ROLES.include? role and site_or_org.class != Org
    raise GlobalErr::ERRORS[:must_be_site] if SITE_ROLES.include? role and site_or_org.class != Site
  end
end
