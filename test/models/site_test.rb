require 'test_helper'
require 'site_org_seeds_test_helper'
require 'user_seeds_test_helper'

class SiteTest < ActiveSupport::TestCase
  setup do
    SiteOrgSeedsTestHelper.clean
    UserSeedsTestHelper.clean

    @org = SiteOrgSeedsTestHelper.seed_org
    @site = SiteOrgSeedsTestHelper.seed_site(@org)
    @user = UserSeedsTestHelper.seed_user

    Role.grant_user_role(@user, :site_manager, @site)
  end
  
  test "returns users who have permissions on this site" do
    site_users = @site.users
    expected_hash = [{
      user: @user.format_for_frontend,
      role: :site_manager.to_s
    }]
    assert_equal(expected_hash, site_users)
  end
end
