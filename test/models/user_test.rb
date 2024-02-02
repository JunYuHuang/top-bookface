require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "does not save user with no properties" do
    user = User.new
    assert_not(user.save)
  end

  test "does not save user with only username" do
    user = User.new(username: "something")
    assert_not(user.save)
  end
end
