require 'test_helper'
require 'user_seeds_test_helper'
require 'site_org_seeds_test_helper'
require 'faker'

class OrgsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    SiteOrgSeedsTestHelper.clean
    UserSeedsTestHelper.clean

    @org = SiteOrgSeedsTestHelper.seed_org
    @user = UserSeedsTestHelper.seed_user
  end

  test "orgs_sites" do
    #TODO: Not yet implemented
    get orgs_sites_path(@org), params: {}
    assert_response 501
  end

  test "orgs_users_show" do
    #TODO: Not yet implemented
    get orgs_users_show_path(@org), params: {}
    assert_response 501
  end

  test "orgs_user_add" do
    #TODO: Not yet implemented
    post orgs_user_add_path(@org), params: {}
    assert_response 501
  end

  test "orgs_user_remove" do
    #TODO: Not yet implemented
    delete orgs_user_remove_path(@org), params: {}
    assert_response 501
  end

  test "orgs_user_edit" do
    #TODO: Not yet implemented
    put orgs_user_edit_path(id: @org.id, uid: @user.id), params: {}
    assert_response 501
  end

end
