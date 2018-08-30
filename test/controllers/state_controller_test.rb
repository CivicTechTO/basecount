require 'test_helper'
require 'user_seeds_test_helper'
require 'site_org_seeds_test_helper'
require 'faker'

class StateControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    SiteOrgSeedsTestHelper.clean
    UserSeedsTestHelper.clean
    @org = SiteOrgSeedsTestHelper.seed_org
    @site = SiteOrgSeedsTestHelper.seed_site(@org)
    @validUser = UserSeedsTestHelper.seed_user
  end

  test "Get the base state - logged in" do
    sign_in @validUser
    get base_state_path
    assert_response 200
  end

  test "Get the base state - logged out" do
    sign_in @validUser
    get base_state_path
    jsonResponse = JSON.parse(response.body)
    assert_response 200
    assert(jsonResponse[:appUser] == nil)
  end

end
