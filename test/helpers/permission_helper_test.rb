require 'test_helper'
require 'user_seeds_test_helper'
require 'site_org_seeds_test_helper'

class PermissionHelperTest < ActiveSupport::TestCase
  include PermissionHelper
  
  def self.test_all_permissions(user,org1,org2,site1,site2,site3)
    
    #p.can_manage_org_users?
    #p.can_manage_org_site_managers?
    #p.can_manage_org_sites?
    #p.can_view_org_historical?
    #p.can_manage_site_users?
    #p.can_manage_site?
    #p.can_add_site_counts?
    #p.can_view_site_historical?
    p_global = Permissions.new({user: user})
    p_org1 = Permissions.new({user: user, org: org1})
    p_org2 = Permissions.new({user: user, org: org2})
    p_site1 = Permissions.new({user: user, site: site1})
    p_site2 = Permissions.new({user: user, site: site2})
    p_site3 = Permissions.new({user: user, site: site3})

    {
      global_view_site_details: p_global.can_view_global_site_details?,
      global_view_counts: p_global.can_view_global_counts?,
      global_manage_orgs: p_global.can_manage_global_orgs?,
      global_manage_users: p_global.can_manage_global_users?,
      
      # org
      org_manage_users: p_org1.can_manage_org_users?,
      org2_manage_users: p_org2.can_manage_org_users?,
      org_manage_site_managers: p_org1.can_manage_org_site_managers?,
      org2_manage_site_managers: p_org2.can_manage_org_site_managers?,
      org_manage_sites: p_org1.can_manage_org_sites?,
      org2_manage_sites: p_org2.can_manage_org_sites?,
      org_view_historical: p_org1.can_view_org_historical?,
      org2_view_historical: p_org2.can_view_org_historical?,
      
      # sites
      site_manage_users: p_site1.can_manage_site_users?,
      site2_manage_users: p_site2.can_manage_site_users?,
      site3_manage_users: p_site3.can_manage_site_users?,
      site_manage_site: p_site1.can_manage_site?,
      site2_manage_site: p_site2.can_manage_site?,
      site3_manage_site: p_site3.can_manage_site?,
      site_add_counts: p_site1.can_add_site_counts?,
      site2_add_counts: p_site2.can_add_site_counts?,
      site3_add_counts: p_site3.can_add_site_counts?,
      site_view_historical: p_site1.can_view_site_historical?,
      site2_view_historical: p_site2.can_view_site_historical?,
      site3_view_historical: p_site3.can_view_site_historical?,
    }
  end

  setup do
    UserSeedsTestHelper.clean
    SiteOrgSeedsTestHelper.clean

    # global
    # - user_global_loggedout1
    # - user_global_loggedin1
    # - user_global_admin1
    # - user_global_dataviewer1
    # org1
    # - user_org_employee1
    # - user_org_manager1
    #  site1
    #  - user_site_employee1
    #  - user_site_manager1
    #  site2
    #  - user_site_employee2
    #  - user_site_manager2
    # org2
    # - user_org_employee1
    # - user_org_manager1


    # orgs and sites
    @org1 = SiteOrgSeedsTestHelper.seed_org
    @org2 = SiteOrgSeedsTestHelper.seed_org
    @site1 = SiteOrgSeedsTestHelper.seed_site(@org1)
    @site2 = SiteOrgSeedsTestHelper.seed_site(@org1)
    @site3 = SiteOrgSeedsTestHelper.seed_site(@org2)
    
    # site_employee
    @user_site_employee1 = UserSeedsTestHelper.seed_user
    Role.grant_user_role(@user_site_employee1, :site_employee, @site1)
    
    # site_manager
    @user_site_manager1 = UserSeedsTestHelper.seed_user
    Role.grant_user_role(@user_site_manager1, :site_manager, @site1)
    
    # org_employee
    @user_org_employee1 = UserSeedsTestHelper.seed_user
    Role.grant_user_role(@user_org_employee1, :org_employee, @org1)
    
    # org_manager
    @user_org_manager1 = UserSeedsTestHelper.seed_user
    Role.grant_user_role(@user_org_manager1, :org_manager, @org1)
    
    # global_admin
    @user_global_admin1 = UserSeedsTestHelper.seed_user
    Role.grant_user_role(@user_global_admin1, :global_admin)
    
    # global_dataviewer
    @user_global_dataviewer1 = UserSeedsTestHelper.seed_user
    Role.grant_user_role(@user_global_dataviewer1, :global_dataviewer)
    
    # global_loggedin
    @user_global_loggedin1 = UserSeedsTestHelper.seed_user
    
    # global_loggedout
    @user_global_loggedout1 = nil

  end

  test "user_site_employee" do
    expected_permissions = {
      global_view_site_details: true,
      global_view_counts: false,
      global_manage_orgs: false,
      global_manage_users: false,

      # org
      org_manage_users: false,
      org2_manage_users: false,
      org_manage_site_managers: false,
      org2_manage_site_managers: false,
      org_manage_sites: false,
      org2_manage_sites: false,
      org_view_historical: false,
      org2_view_historical: false,
      
      # sites
      site_manage_users: false,
      site2_manage_users: false,
      site3_manage_users: false,
      site_manage_site: false,
      site2_manage_site: false,
      site3_manage_site: false,
      site_add_counts: true,
      site2_add_counts: false,
      site3_add_counts: false,
      site_view_historical: true,
      site2_view_historical: false,
      site3_view_historical: false,
    }
    derived_permissions = PermissionHelperTest.test_all_permissions(@user_site_employee1,@org1,@org2,@site1,@site2,@site3)

    assert_equal(expected_permissions,derived_permissions)
  end

  test "user_site_manager" do
    expected_permissions = {
      global_view_site_details: true,
      global_view_counts: false,
      global_manage_orgs: false,
      global_manage_users: false,

      # org
      org_manage_users: false,
      org2_manage_users: false,
      org_manage_site_managers: false,
      org2_manage_site_managers: false,
      org_manage_sites: false,
      org2_manage_sites: false,
      org_view_historical: false,
      org2_view_historical: false,
      
      # sites
      site_manage_users: true,
      site2_manage_users: false,
      site3_manage_users: false,
      site_manage_site: true,
      site2_manage_site: false,
      site3_manage_site: false,
      site_add_counts: true,
      site2_add_counts: false,
      site3_add_counts: false,
      site_view_historical: true,
      site2_view_historical: false,
      site3_view_historical: false,
    }
    derived_permissions = PermissionHelperTest.test_all_permissions(@user_site_manager1,@org1,@org2,@site1,@site2,@site3)

    assert_equal(expected_permissions,derived_permissions)
  end

  test "user_org_employee" do
    expected_permissions = {
      global_view_site_details: true,
      global_view_counts: false,
      global_manage_orgs: false,
      global_manage_users: false,

      # org
      org_manage_users: false,
      org2_manage_users: false,
      org_manage_site_managers: false,
      org2_manage_site_managers: false,
      org_manage_sites: true,
      org2_manage_sites: false,
      org_view_historical: true,
      org2_view_historical: false,
      
      # sites
      site_manage_users: false,
      site2_manage_users: false,
      site3_manage_users: false,
      site_manage_site: false,
      site2_manage_site: false,
      site3_manage_site: false,
      site_add_counts: false,
      site2_add_counts: false,
      site3_add_counts: false,
      site_view_historical: false,
      site2_view_historical: false,
      site3_view_historical: false,
    }
    derived_permissions = PermissionHelperTest.test_all_permissions(@user_org_employee1,@org1,@org2,@site1,@site2,@site3)

    assert_equal(expected_permissions,derived_permissions)
  end

  test "user_org_manager" do
    expected_permissions = {
      global_view_site_details: true,
      global_view_counts: false,
      global_manage_orgs: false,
      global_manage_users: false,

      # org
      org_manage_users: true,
      org2_manage_users: false,
      org_manage_site_managers: true,
      org2_manage_site_managers: false,
      org_manage_sites: true,
      org2_manage_sites: false,
      org_view_historical: true,
      org2_view_historical: false,
      
      # sites
      site_manage_users: false,
      site2_manage_users: false,
      site3_manage_users: false,
      site_manage_site: false,
      site2_manage_site: false,
      site3_manage_site: false,
      site_add_counts: false,
      site2_add_counts: false,
      site3_add_counts: false,
      site_view_historical: false,
      site2_view_historical: false,
      site3_view_historical: false,
    }
    derived_permissions = PermissionHelperTest.test_all_permissions(@user_org_manager1,@org1,@org2,@site1,@site2,@site3)

    assert_equal(expected_permissions,derived_permissions)
  end

  test "user_global_admin" do
    expected_permissions = {
      global_view_site_details: true,
      global_view_counts: true,
      global_manage_orgs: true,
      global_manage_users: true,

      # org
      org_manage_users: true,
      org2_manage_users: true,
      org_manage_site_managers: true,
      org2_manage_site_managers: true,
      org_manage_sites: true,
      org2_manage_sites: true,
      org_view_historical: true,
      org2_view_historical: true,
      
      # sites
      site_manage_users: true,
      site2_manage_users: true,
      site3_manage_users: true,
      site_manage_site: true,
      site2_manage_site: true,
      site3_manage_site: true,
      site_add_counts: true,
      site2_add_counts: true,
      site3_add_counts: true,
      site_view_historical: true,
      site2_view_historical: true,
      site3_view_historical: true,
    }
    derived_permissions = PermissionHelperTest.test_all_permissions(@user_global_admin1,@org1,@org2,@site1,@site2,@site3)

    assert_equal(expected_permissions,derived_permissions)
  end

  test "user_global_dataviewer" do
    expected_permissions = {
      global_view_site_details: true,
      global_view_counts: true,
      global_manage_orgs: false,
      global_manage_users: false,

      # org
      org_manage_users: false,
      org2_manage_users: false,
      org_manage_site_managers: false,
      org2_manage_site_managers: false,
      org_manage_sites: false,
      org2_manage_sites: false,
      org_view_historical: false,
      org2_view_historical: false,
      
      # sites
      site_manage_users: false,
      site2_manage_users: false,
      site3_manage_users: false,
      site_manage_site: false,
      site2_manage_site: false,
      site3_manage_site: false,
      site_add_counts: false,
      site2_add_counts: false,
      site3_add_counts: false,
      site_view_historical: false,
      site2_view_historical: false,
      site3_view_historical: false,
    }
    derived_permissions = PermissionHelperTest.test_all_permissions(@user_global_dataviewer1,@org1,@org2,@site1,@site2,@site3)

    assert_equal(expected_permissions,derived_permissions)
  end

  test "user_global_loggedin" do
    expected_permissions = {
      global_view_site_details: true,
      global_view_counts: false,
      global_manage_orgs: false,
      global_manage_users: false,

      # org
      org_manage_users: false,
      org2_manage_users: false,
      org_manage_site_managers: false,
      org2_manage_site_managers: false,
      org_manage_sites: false,
      org2_manage_sites: false,
      org_view_historical: false,
      org2_view_historical: false,
      
      # sites
      site_manage_users: false,
      site2_manage_users: false,
      site3_manage_users: false,
      site_manage_site: false,
      site2_manage_site: false,
      site3_manage_site: false,
      site_add_counts: false,
      site2_add_counts: false,
      site3_add_counts: false,
      site_view_historical: false,
      site2_view_historical: false,
      site3_view_historical: false,
    }
    derived_permissions = PermissionHelperTest.test_all_permissions(@user_global_loggedin1,@org1,@org2,@site1,@site2,@site3)

    assert_equal(expected_permissions,derived_permissions)
  end

  test "user_global_loggedout" do
    expected_permissions = {
      global_view_site_details: false,
      global_view_counts: false,
      global_manage_orgs: false,
      global_manage_users: false,

      # org
      org_manage_users: false,
      org2_manage_users: false,
      org_manage_site_managers: false,
      org2_manage_site_managers: false,
      org_manage_sites: false,
      org2_manage_sites: false,
      org_view_historical: false,
      org2_view_historical: false,
      
      # sites
      site_manage_users: false,
      site2_manage_users: false,
      site3_manage_users: false,
      site_manage_site: false,
      site2_manage_site: false,
      site3_manage_site: false,
      site_add_counts: false,
      site2_add_counts: false,
      site3_add_counts: false,
      site_view_historical: false,
      site2_view_historical: false,
      site3_view_historical: false,
    }
    derived_permissions = PermissionHelperTest.test_all_permissions(@user_global_loggedout1,@org1,@org2,@site1,@site2,@site3)

    assert_equal(expected_permissions,derived_permissions)
  end

end
