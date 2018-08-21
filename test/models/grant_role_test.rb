require 'test_helper'
require 'user_seeds_test_helper'
require 'site_org_seeds_test_helper'
require 'global_err'

class GrantRoleTest < ActiveSupport::TestCase
  setup do
    UserSeedsTestHelper.clean
    SiteOrgSeedsTestHelper.clean
    
    @user = UserSeedsTestHelper.seed_user
    @notUser = 'hello'
    @org = SiteOrgSeedsTestHelper.seed_org
    @org2 = SiteOrgSeedsTestHelper.seed_org
    @site = SiteOrgSeedsTestHelper.seed_site(@org)
    @site2 = SiteOrgSeedsTestHelper.seed_site(@org)
  end

  # TODO: should one be able to add a user to multiple global roles, or multiple site roles on the same site, or multiple org roles on the same org?

  test 'Valid Role' do
    assert Role.grant_user_role(@user,:global_admin)
  end

  test 'Invalid Role' do
    exception = assert_raises(Exception) do
      Role.grant_user_role(@user,:baz)
    end
  end

  test 'Invalid User' do
    exception = assert_raises(Exception) do
      Role.grant_user_role(@notUser,:global_admin)
    end

    assert_equal(GlobalErr::ERRORS[:invalid_user], exception.to_s)
  end

  test 'Add user to Role - Global' do
    user = UserSeedsTestHelper.seed_user
    Role.grant_user_role(user, :global_admin)
    assert_equal(:global_admin.to_s, user.roles[0].role)
  end

  test 'Add user to Role - Site' do
    user = UserSeedsTestHelper.seed_user
    Role.grant_user_role(user, :site_employee, @site)
    assert_equal(:site_employee.to_s, user.roles[0].role)
    assert_equal(@site, user.roles[0].site)
  end

  test 'Add user to Role - Org' do
    user = UserSeedsTestHelper.seed_user
    Role.grant_user_role(user, :org_employee, @org)
    assert_equal(:org_employee.to_s, user.roles[0].role)
    assert_equal(@org, user.roles[0].org)
  end

  test 'Roles should not be added twice - global' do
    user = UserSeedsTestHelper.seed_user
    Role.grant_user_role(user, :global_admin)
    Role.grant_user_role(user, :global_admin)
    assert_equal(1,user.roles.length)
  end

  test 'Roles should not be added twice - org' do
    user = UserSeedsTestHelper.seed_user
    Role.grant_user_role(user, :org_employee, @org)
    Role.grant_user_role(user, :org_employee, @org)
    assert_equal(1,user.roles.length)
  end

  test 'Roles should not be added twice - site' do
    user = UserSeedsTestHelper.seed_user
    Role.grant_user_role(user, :site_employee, @site)
    Role.grant_user_role(user, :site_employee, @site)
    assert_equal(1,user.roles.length)
  end

  test 'Add user to the same role on different sites' do
    user = UserSeedsTestHelper.seed_user
    Role.grant_user_role(user, :site_employee, @site)
    Role.grant_user_role(user, :site_employee, @site2)
    assert_equal(2,user.roles.length)
  end

  test 'Add user to the same role on different orgs' do
    user = UserSeedsTestHelper.seed_user
    Role.grant_user_role(user, :org_employee, @org)
    Role.grant_user_role(user, :org_employee, @org2)
    assert_equal(2,user.roles.length)
  end

end
