module PermissionHelper
  # can a user do x for a given shelter or org?

  ####################
  #  PERMISSIONS
  ####################

  # global_view_site_details
  def can_view_site_details
    true
  end
  # PERMISSION: global_view_site_details / ROLE: global_loggedin
  # PERMISSION: global_view_counts / ROLE: global_dataviewer
  # PERMISSION: global_view_counts / ROLE: global_admin
  # PERMISSION: global_manage_orgs / ROLE: global_admin
  # PERMISSION: global_manage_users / ROLE: global_admin    
  # PERMISSION: org_manage_users / ROLE: org_manager
  # PERMISSION: org_manage_site_managers / ROLE: org_manager
  # PERMISSION: org_manage_sites / ROLE: org_employee
  # PERMISSION: org_view_historical / ROLE: org_employee    
  # PERMISSION: site_manage_users / ROLE: site_manager
  # PERMISSION: site_manage_site / ROLE: site_manager
  # PERMISSION: site_add_counts / ROLE: site_volunteer
  # PERMISSION: site_view_historical / ROLE: site_volunteer
end