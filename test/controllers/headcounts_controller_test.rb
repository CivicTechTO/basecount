require 'test_helper'
require 'site_org_seeds_test_helper'
require 'user_seeds_test_helper'

class HeadcountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org = SiteOrgSeedsTestHelper.seed_org
    @site = SiteOrgSeedsTestHelper.seed_site(@org)
    @room = Room.create({
      site: @site,
      capacity: 100
    })
    @validUser = UserSeedsTestHelper.seed_user
    
    # TODO: need to add permissions on create to break it
    @headcount_create_params = {
      room_id: @room.id,
      recorded_by_id: @validUser.id,
      occupancy: 50
    }
    
    @headcount = Headcount.create(@headcount_create_params)
  end

  test "should get index" do
    get headcounts_url, as: :json
    assert_response :success
  end

  test "should create headcount" do
    assert_difference 'Headcount.count' do
      post headcounts_url, params: { headcount: @headcount_create_params }, as: :json
    end

    assert_response 201
  end

  test "should show headcount" do
    get headcount_url(@headcount), as: :json
    assert_response :success
  end

  test "should update headcount" do
    patch headcount_url(@headcount), params: { headcount: {  } }, as: :json
    assert_response 200
  end

  test "should destroy headcount" do
    assert_difference('Headcount.count', -1) do
      delete headcount_url(@headcount), as: :json
    end

    assert_response 204
  end
end
