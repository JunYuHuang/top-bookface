require "test_helper"

class AuthenticatedFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "is redirected if visiting the user sign in page while authenticated" do
    sign_in users(:user_1)
    get "/users/sign_in"
    assert_response :redirect
    assert_response 302
    assert_redirected_to "/"
  end

  test "is redirected if visiting the user sign up page while authenticated" do
    sign_in users(:user_1)
    get "/users/sign_up"
    assert_response :redirect
    assert_response 302
    assert_redirected_to "/"
  end

  test "can see the root page when signed in" do
    sign_in users(:user_1)
    get "/"
    assert_select("a", "New Post")
  end

  test "can see the posts show page for post 1 when signed in" do
    sign_in users(:user_1)
    get "/posts/1"
    assert_select("h1", "Post: 1")
  end
end
