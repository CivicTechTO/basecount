require 'test_helper'
require 'user_seeds_test_helper'
require 'global_err'

class RoleTest < ActiveSupport::TestCase
  setup do
    @user = UserSeedsTestHelper.seed_user
    @notUser = 'hello'
  end

  test 'Valid Role' do
    assert Role.grant_user_role(@user,:global_admin)
  end
  
  test 'Invalid Role' do
    exception = assert_raises(Exception) do
      Role.grant_user_role(@user,:baz)
    end
  end

  test 'Invalid User' do
    exception = assert_raises(Exception) do
      Role.grant_user_role(@notUser,:global_admin)
    end

    assert_equal(GlobalErr::ERRORS[:invalid_user], exception.to_s)
  end

  test 'Add user to Role' do
    user = UserSeedsTestHelper.seed_user
    Role.grant_user_role(user, :global_admin)
    puts 'the roles'
    puts user.roles
    assert_equal(:global_admin.to_s, user.roles[0].role)
  end

  test 'Roles should not be added twice' do
    user = UserSeedsTestHelper.seed_user
    Role.grant_user_role(user, :global_admin)
    Role.grant_user_role(user, :global_admin)
    assert_equal(1,user.roles.length)
  end

  # test 'Not giving scope when necessary' do
  #   assert_raises(Exception) {
  #     Role.grant_user_role(@notUser,:site_employee)
  #   }
  # end
end
