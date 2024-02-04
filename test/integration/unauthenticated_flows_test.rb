require "test_helper"

class UnauthenticatedFlowsTest < ActionDispatch::IntegrationTest
  test "can see the user sign in page" do
    get "/users/sign_in"
    assert_select("h2", "Sign In")
  end

  test "can see the user sign up page" do
    get "/users/sign_up"
    assert_select("h2", "Sign Up")
  end

  test "is redirected if visiting the root path" do
    get "/"
    assert_response :redirect
    assert_response 302
    assert_redirected_to "/users/sign_in"
  end
end
