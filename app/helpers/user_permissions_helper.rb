module UserPermissionsHelper
  # PERMISSION: global_view_counts / ROLE: global_dataviewer
  # PERMISSION: global_view_counts / ROLE: global_admin
  def can_view_global_counts?
    self.has_role?(:global_admin) or
    self.has_role?(:global_dataviewer)
  end

  # PERMISSION: global_manage_orgs / ROLE: global_admin
  def can_manage_global_orgs?
    self.has_role?(:global_admin)
  end

  # PERMISSION: global_manage_users / ROLE: global_admin    
  def can_manage_global_users?
    self.has_role?(:global_admin)
  end

  # PERMISSION: org_manage_users / ROLE: org_manager
  def can_manage_org_users? org
    self.has_role?(:global_admin) or
    self.has_role?(:org_manager, org)
  end

  # PERMISSION: org_manage_site_managers / ROLE: org_manager
  def can_manage_org_site_managers? org
    self.has_role?(:global_admin) or
    self.has_role?(:org_manager, org)
  end

  # PERMISSION: org_manage_sites / ROLE: org_employee
  def can_manage_org_sites? org
    self.has_role?(:global_admin) or
    self.has_role?(:org_manager, org) or
    self.has_role?(:org_employee, org)
  end

  # PERMISSION: org_view_historical / ROLE: org_employee    
  def can_view_org_historical? org
    self.has_role?(:global_admin) or
    self.has_role?(:org_manager, org) or
    self.has_role?(:org_employee, org)
  end

  # PERMISSION: site_manage_users / ROLE: site_manager
  def can_manage_site_users? site
    self.has_role?(:global_admin) or
    self.has_role?(:site_manager, site) or
    self.is_org_level?(site.org)
  end

  # PERMISSION: site_manage_site / ROLE: site_manager
  def can_manage_site? site
    self.has_role?(:global_admin) or
    self.has_role?(:site_manager, site) or
    self.is_org_level?(site.org)
  end

  # PERMISSION: site_add_counts / ROLE: site_employee
  def can_add_site_counts? site
    self.has_role?(:global_admin) or
    self.has_role?(:site_manager, site) or
    self.has_role?(:site_employee, site) or
    self.is_org_level?(site.org)
  end

  # PERMISSION: site_view_historical / ROLE: site_employee
  def can_view_site_historical? site
    self.has_role?(:global_admin) or
    self.has_role?(:site_manager, site) or
    self.has_role?(:site_employee, site) or
    self.is_org_level?(site.org)
  end

  def is_org_level? org
    self.has_role?(:org_employee, org) or
    self.has_role?(:org_manager, org)
  end
end