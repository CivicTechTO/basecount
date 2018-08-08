require 'test_helper'
require 'user_seeds_test_helper'
require 'site_org_seeds_test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    UserSeedsTestHelper.clean
    SiteOrgSeedsTestHelper.clean

    @org1 = SiteOrgSeedsTestHelper.seed_org
    @site1 = SiteOrgSeedsTestHelper.seed_site(@org1)
    
    @site_manager = UserSeedsTestHelper.seed_user
    Role.grant_user_role(@site_manager, :site_manager, @site1)
    
    @org_employee = UserSeedsTestHelper.seed_user
    Role.grant_user_role(@org_employee, :org_employee, @org1)
  end


  test "Both site managers and org employees can manage sites" do
    assert @site_manager.can_manage_site? @site1
    assert @org_employee.can_manage_site? @site1
  end

  test "format_for_frontend" do
    expected_hash = {
      "first_name" => @site_manager.first_name,
      "last_name" => @site_manager.last_name,
      "email" => @site_manager.email,
      "id" => @site_manager.id,
    }
    assert_equal(expected_hash, @site_manager.format_for_frontend)
  end
end
