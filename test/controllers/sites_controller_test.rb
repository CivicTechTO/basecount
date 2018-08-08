require 'test_helper'
require 'user_seeds_test_helper'
require 'site_org_seeds_test_helper'
require 'faker'

class SitesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    UserSeedsTestHelper.clean
    SiteOrgSeedsTestHelper.clean

    @site_request_params = {
      name: "test",
      address1: "test",
      city: "test",
      postal_code: "test",
    }

    
    @org = SiteOrgSeedsTestHelper.seed_org
    @site = SiteOrgSeedsTestHelper.seed_site(@org)
    
    @site_create_params = @site_request_params.merge(org_id: @org.id)

    @org_user = UserSeedsTestHelper.seed_user
    Role.grant_user_role(@org_user, :org_employee, @org)
    @invalid_user = UserSeedsTestHelper.seed_user
    Role.grant_user_role(@invalid_user, :global_dataviewer)
    @site_user = UserSeedsTestHelper.seed_user
    Role.grant_user_role(@site_user, :site_employee, @site)
  end

  test "should create site - logged in & authed" do
    skip("Broken -- need to fix.")
    sign_in @org_user
    # TODO: Need to check auth
    assert_difference('Site.count') do
      post sites_new_path, params: { site: @site_create_params }, as: :json
    end

    assert_response 201
  end

  test "shouldn't create site - bad user" do
    sign_in @invalid_user
    # TODO: Need to check auth
    assert_no_changes('Site.count') do
      post sites_new_path, params: { site: @site_create_params }, as: :json
    end

    assert_response 403
  end


  test "should show site" do
    # TODO: Not yet implemented
    get sites_show_path(@site)
    assert_response :error
  end

  

  test "should update site" do
    skip("Broken -- need to fix.")
    # TODO: need to check auth
    # TODO: will need to accept general, services, and schedule:
    # https://www.figma.com/proto/dk4oQvyGyFsljLaKXSBwM9zC/basecount-wireframes?redirected=1&scaling=min-zoom&node-id=98%3A1499
    put sites_update_path(@site), params: { site: @site_request_params.merge({name: 'test2'}) }, as: :json
    assert_response 200
  end

  test "Show users who have permission on a site - not signed in" do
    get sites_users_show_path(@site)
    assert_response 403
  end

  test "Show users who have permission on a site - wrong user permissions" do
    sign_in @invalid_user
    get sites_users_show_path(@site)
    assert_response 403
  end

  test "Show users who have permission on a site - signed in" do
    sign_in @org_user
    get sites_users_show_path(@site)
    
    json_response = JSON.parse(response.body)
    expected_hash = [{
      "user" => @site_user.format_for_frontend,
      "role" => "site_employee"
    }]
    
    assert_equal(expected_hash, json_response)
    assert_response 200
  end


  test "Add a user to a site" do
    post sites_user_add_path(@site)
    # TODO: Not yet implemented
    assert_response 501
  end


  test "Edit a user on a site" do
    put sites_user_edit_path(id: 1, uid: 1)
    # TODO: Not yet implemented
    assert_response 501
  end


  test "Remove a user from a site" do
    delete sites_user_remove_path(id: 1, uid: 1)
    # TODO: Not yet implemented
    assert_response 501
  end


  test "See site headcounts" do
    get sites_headcounts_path(@site)
    # TODO: Not yet implemented
    assert_response 501
  end

end
