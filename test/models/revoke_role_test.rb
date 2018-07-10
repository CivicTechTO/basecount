require 'test_helper'
require 'user_seeds_test_helper'
require 'site_org_seeds_test_helper'
require 'global_err'

class RevokeRoleTest < ActiveSupport::TestCase
  setup do
    UserSeedsTestHelper.clean
    SiteOrgSeedsTestHelper.clean

    @org = SiteOrgSeedsTestHelper.seed_org
    @org2 = SiteOrgSeedsTestHelper.seed_org
    @site = SiteOrgSeedsTestHelper.seed_site(@org)
    @site2 = SiteOrgSeedsTestHelper.seed_site(@org)
  end


  test 'remove the only role' do
    user = UserSeedsTestHelper.seed_user
    Role.grant_user_role( user, :site_manager, @site )
    assert_equal(1,user.roles.length)
    Role.revoke_user_role( user, :site_manager, @site)
    assert_equal(0,user.roles.length)
  end

  test 'remove only one role of many' do
    user = UserSeedsTestHelper.seed_user
    Role.grant_user_role( user, :site_manager, @site )
    Role.grant_user_role( user, :site_manager, @site2 )
    assert_equal(2,user.roles.length)
    Role.revoke_user_role( user, :site_manager, @site)
    assert_equal(1,user.roles.length)
    assert_equal(:site_manager.to_s, user.roles[0].role)
    assert_equal(@site2, user.roles[0].site)
  end

  test 'remove one role of many - same site' do
    user = UserSeedsTestHelper.seed_user
    Role.grant_user_role( user, :site_manager, @site )
    Role.grant_user_role( user, :site_employee, @site )
    assert_equal(2,user.roles.length)
    Role.revoke_user_role( user, :site_manager, @site)
    assert_equal(1,user.roles.length)
    assert_equal(:site_employee.to_s, user.roles[0].role)
  end
end
