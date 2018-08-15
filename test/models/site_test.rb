require 'test_helper'
require 'site_org_seeds_test_helper'
require 'user_seeds_test_helper'

class SiteTest < ActiveSupport::TestCase
  setup do
    SiteOrgSeedsTestHelper.clean
    UserSeedsTestHelper.clean
    SiteOrgSeedsTestHelper.seed_aspects

    
    @aspect_wheelchair = Aspect.find(1)
    @aspect_other = Aspect.find(2)
    
    @org = SiteOrgSeedsTestHelper.seed_org
    @site = SiteOrgSeedsTestHelper.seed_site(@org)
    @site_for_aspects = SiteOrgSeedsTestHelper.seed_site(@org)
    @user = UserSeedsTestHelper.seed_user
    
    Role.grant_user_role(@user, :site_manager, @site)
    
    @site_frontend_hash = {
      general: {
        org_id: @org.id,
        name: "this is the name",
        address: "1234 fake street",
        postal_code: "X0X0X0",
        phone: "4161234567",
      },
      services: {
        services: "Some Services",
        populations: [1,2,3]
      },
      # TODO: Schedule 
      # schedule: {
      # }
    }
  end
  
  test "returns users who have permissions on this site" do
    site_users = @site.users
    expected_hash = [{
      user: @user.format_for_frontend,
      role: :site_manager.to_s
    }]
    assert_equal(expected_hash, site_users)
  end

  # Not yet in use
  # test "save aspects" do
  #   @site_for_aspects.save_aspects!([@aspect_other])
  #   @site_for_aspects.save_aspects!([ @aspect_wheelchair, @aspect_wheelchair, @aspect_other])
    
  #   assert_equal([@aspect_other, @aspect_wheelchair], @site_for_aspects.aspects)
  # end

  test "population whitelists default" do
    site_for_pop_default = SiteOrgSeedsTestHelper.seed_site(@org)
    assert_equal([], site_for_pop_default.populations)
  end

  test "add to population whitelist" do
    site_for_pop =  SiteOrgSeedsTestHelper.seed_site(@org)
    site_for_pop.populations = [:women, :men, :children]
    expected = [
      { code: :women, pretty: "Women" },
      { code: :men, pretty: "Men" },
      { code: :children, pretty: "Children" },
    ]
    assert_equal(expected, site_for_pop.populations)
  end

  test "create from frontend hash" do
    s = Site.new_from_frontend(@site_frontend_hash)

    s.save!
    puts s
    assert true
  end


end
