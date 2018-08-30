require 'test_helper'
require 'user_seeds_test_helper'
require 'site_org_seeds_test_helper'
require 'faker'

class SitesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # TODO: test helper to create aspects

  setup do
    UserSeedsTestHelper.clean
    SiteOrgSeedsTestHelper.clean

    # used for creation AND update
    @site_property_hash_base = {
      general: {
        name: "this is the name",
        address: "1234 fake street",
        postal_code: "X0X0X0",
        phone: "4161234567",
        default_capacity: 100,
      },
      services: {
        services: "Some Services",
        populations: [1,2,3]
      },
      # TODO: Schedule 
      # schedule: {
      # }
    }

    
    @org = SiteOrgSeedsTestHelper.seed_org
    @site = SiteOrgSeedsTestHelper.seed_site(@org)
    
    @site_create_params = @site_property_hash_base.clone
    @site_create_params[:general][:org_id] = @org.id

    @site_update_params = @site_property_hash_base.clone
    @site_update_params[:general][:name] = "new name"

    @org_user = UserSeedsTestHelper.seed_user
    Role.grant_user_role(@org_user, :org_employee, @org)
    @dataviewer_user = UserSeedsTestHelper.seed_user
    Role.grant_user_role(@dataviewer_user, :global_dataviewer)
    @site_user = UserSeedsTestHelper.seed_user
    Role.grant_user_role(@site_user, :site_employee, @site)
  end

  test "If a bad site is given, urls should 404" do
    get sites_users_show_path(id: 99999)
    assert_response 404
  end

  test "should create site - logged in & authed" do
    # Need to override default create behaviour
    sign_in @org_user
    assert_difference('Site.count') do
      post sites_new_path, params: @site_create_params, as: :json
    end

    assert_response 201
  end

  test "shouldn't create site - bad user" do
    sign_in @dataviewer_user
    assert_no_changes('Site.count') do
      post sites_new_path, params: @site_create_params, as: :json
    end

    assert_response 403
  end


  test "should show site - logged in & authed" do
    sign_in @org_user
    site = Site.new_from_frontend(@site_create_params)
    site.save
    
    get sites_show_path(site)
    json_response = JSON.parse(response.body)

    assert_equal(@org.id, json_response["general"]["org_id"])
    assert_response 200
  end

  test "shouldn't show site - bad user" do
    sign_in @dataviewer_user
    get sites_show_path(@site)

    assert_response 403
  end

  

  test "should update site - logged in & authed" do
    sign_in @org_user
    put sites_update_path(@site), params: @site_update_params, as: :json
    assert_response 200
  end

  test "Show users who have permission on a site - not signed in" do
    get sites_users_show_path(@site)
    assert_response 403
  end

  test "Show users who have permission on a site - wrong user permissions" do
    sign_in @dataviewer_user
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
