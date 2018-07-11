module PermissionHelper
  class Permissions
    def initialize(hash = {})
      @user = hash[:user]
      @site = hash[:site]
      @org = hash[:org]
      @global_permission = @site.nil? and @org.nil?
    end
    
    # todo: can org level people do everything all the way down?

    ####################
    #  PERMISSIONS
    ####################

    # PERMISSION: global_view_site_details / ROLE: global_loggedin
    def can_view_global_site_details
      !@user.nil?
    end
    
    # PERMISSION: global_view_counts / ROLE: global_dataviewer
    # PERMISSION: global_view_counts / ROLE: global_admin
    def can_view_global_counts
      return false if @user.nil?
      @user.has_role?(:global_admin) or
      @user.has_role?(:global_dataviewer)
    end

    # PERMISSION: global_manage_orgs / ROLE: global_admin
    def can_manage_global_orgs
      return false if @user.nil?
      @user.has_role?(:global_admin)
    end

    # PERMISSION: global_manage_users / ROLE: global_admin    
    def can_manage_global_users
      return false if @user.nil?
      @user.has_role?(:global_admin)
    end

    # PERMISSION: org_manage_users / ROLE: org_manager
    def can_manage_org_users
      return false if @user.nil?
      @user.has_role?(:global_admin) or
      @user.has_role?(:org_manager, @org)
    end

    # PERMISSION: org_manage_site_managers / ROLE: org_manager
    def can_manage_org_site_managers
      return false if @user.nil?
      @user.has_role?(:global_admin) or
      @user.has_role?(:org_manager, @org)
    end

    # PERMISSION: org_manage_sites / ROLE: org_employee
    def can_manage_org_sites
      return false if @user.nil?
      @user.has_role?(:global_admin) or
      @user.has_role?(:org_manager, @org) or
      @user.has_role?(:org_employee, @org)
    end

    # PERMISSION: org_view_historical / ROLE: org_employee    
    def can_view_org_historical
      return false if @user.nil?
      @user.has_role?(:global_admin) or
      @user.has_role?(:org_manager, @org) or
      @user.has_role?(:org_employee, @org)
    end

    # PERMISSION: site_manage_users / ROLE: site_manager
    def can_manage_site_users
      return false if @user.nil?
      @user.has_role?(:global_admin) or
      @user.has_role?(:site_manager, @site)
    end

    # PERMISSION: site_manage_site / ROLE: site_manager
    def can_manage_site
      return false if @user.nil?
      @user.has_role?(:global_admin) or
      @user.has_role?(:site_manager, @site)
    end

    # PERMISSION: site_add_counts / ROLE: site_employee
    def can_add_site_counts
      return false if @user.nil?
      @user.has_role?(:global_admin) or
      @user.has_role?(:site_manager, @site) or
      @user.has_role?(:site_employee, @site)
    end

    # PERMISSION: site_view_historical / ROLE: site_employee
    def can_view_site_historical
      return false if @user.nil?
      @user.has_role?(:global_admin) or
      @user.has_role?(:site_manager, @site) or
      @user.has_role?(:site_employee, @site)
    end
  end

end