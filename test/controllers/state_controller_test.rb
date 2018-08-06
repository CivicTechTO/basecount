require 'test_helper'
require 'user_seeds_test_helper'
require 'site_org_seeds_test_helper'
require 'faker'

class StateControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do

  end

  test "Get the base state" do
    #TODO: Not yet implemented
    get base_state_path
    assert_response 501
  end

end
