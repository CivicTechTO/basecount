require 'test_helper'
require 'user_seeds_test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    UserSeedsTestHelper.clean
    SiteOrgSeedsTestHelper.clean

    @org1 = SiteOrgSeedsTestHelper.seed_org
    @site1 = SiteOrgSeedsTestHelper.seed_site(@org1)
    
    @site_manger = UserSeedsTestHelper.seed_user
    Role.grant_user_role(@site_manger, :site_manager, @site1)
    
    @org_employee = UserSeedsTestHelper.seed_user
    Role.grant_user_role(@org_employee, :org_employee, @org1)
  end


  test "Both site managers and org employees can manage sites" do
    assert @site_manger.can_manage_site? @site1
    assert @org_employee.can_manage_site? @site1
  end
end
