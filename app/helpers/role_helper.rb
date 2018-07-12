module RoleHelper
  # helper helpers
  def role_scopes_global ( user )
    user.role_scopes.where(shelter: null, org: null)
  end


  # site_volunteer
  # site_employee
  # site_manager
  # org_employee
  # org_manager
  # global_admin
  # global_dataviewer
  def dataviewer? ( user )
    
  end
  # global_loggedout
  def loggedout?
    ! user_signed_in?
  end
  # global_loggedin
  def loggedin?
    user_signed_in?
  end
end