require 'test_helper'
require 'site_org_seeds_test_helper'
require 'user_seeds_test_helper'

class HeadcountsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    SiteOrgSeedsTestHelper.clean
    UserSeedsTestHelper.clean
    
    @org = SiteOrgSeedsTestHelper.seed_org
    @site = SiteOrgSeedsTestHelper.seed_site(@org)
    @room = Room.create({
      site: @site,
      capacity: 100
    })
    @validUser = UserSeedsTestHelper.seed_user
    @validUser = Role.grant_user_role(@validUser, :site_employee, @site)
    @dataViewerUser = UserSeedsTestHelper.seed_user
    @dataViewerUser = Role.grant_user_role(@dataViewerUser, :global_dataviewer)
    
    @headcount_web_request_params = {
      room_id: @room.id,
      occupancy: 50,
    }

    @headcount_manual_create_params = {
      recorded_by: @validUser,
      room: @room,
      occupancy: 50,
      recorded_at: Time.now,
      capacity: 60
    }

    @headcount = Headcount.create!(@headcount_manual_create_params)

    # an old headcount
    old_time = Time.now - (Rails.application.config.headcount_edit_window_minutes + 1).minutes
    @old_headcount = Headcount.create!(@headcount_manual_create_params.merge({ recorded_at: old_time}))
  end

  test "should create headcount" do
    sign_in @validUser
    assert_difference 'Headcount.count' do
      post headcounts_new_path, params: { headcount: @headcount_web_request_params }, as: :json
    end

    assert_response 201
  end

  test "shouldn't create headcount with bad room" do
    sign_in @validUser
    bad_room_params = {
      room_id: 999999999,
      occupancy: 50
    }

    post headcounts_new_path, params: { headcount: bad_room_params }, as: :json
    assert_response 400
  end

  test "shouldn't create headcount if signed out" do
    post headcounts_new_path, params: { headcount: @headcount_web_request_params }, as: :json
    assert_response 403
  end

  test "shouldn't create headcount if unauthorized user" do
    sign_in @dataViewerUser
    post headcounts_new_path, params: { headcount: @headcount_web_request_params }, as: :json
    assert_response 403
  end

  test "should show headcount" do
    sign_in @dataViewerUser
    get headcounts_show_path(@headcount), as: :json
    json_body = JSON.parse(response.body)
    expected_keys = ["id","site","recorded_by_id","recorded_at","capacity","occupancy"]
    assert(expected_keys.eql? json_body.keys)
    assert_response 200
  end

  test "shouldn't show headcount to logged out user" do
    get headcounts_show_path(@headcount), as: :json
    assert_response 403
  end

  test "should update recently changed headcount" do
    sign_in @validUser
    put headcounts_update_path(@headcount), params: { headcount: { occupancy: 10  } }, as: :json
    assert_response 200
  end

  test "should not update old headcount" do
    sign_in @validUser
    put headcounts_update_path(@old_headcount), params: { headcount: { occupancy: 20  } }, as: :json
    assert_response 400
  end

  test "should not update headcount if signed out" do
    put headcounts_update_path(@headcount), params: { headcount: { occupancy: 20  } }, as: :json
    assert_response 403
  end

  test "should not update headcount if unauthorized user" do
    sign_in @dataViewerUser
    put headcounts_update_path(@headcount), params: { headcount: { occupancy: 20  } }, as: :json
    assert_response 403
  end

end
