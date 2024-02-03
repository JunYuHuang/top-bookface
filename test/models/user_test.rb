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

  test "user_1 has 1 follower" do
    followers = User.first.followers
    assert(followers.size == 1)
  end

  test "user_2 has 1 followee" do
    followees = User.second.followees
    assert(followees.size == 1)
  end

  test "user_1 has 1 sent follow request" do
    sent_follow_requests = User.first.sent_follow_requests
    assert(sent_follow_requests.size == 1)
  end

  test "user_2 has 1 received follow request" do
    received_follow_requests = User.second.received_follow_requests
    assert(received_follow_requests.size == 1)
  end

  test "user_1 has 1 post" do
    posts = User.first.posts
    assert(posts.size == 1)
  end

  test "user_1 has 1 comment" do
    comments = User.first.comments
    assert(comments.size == 1)
  end

  test "user_1 has 1 like" do
    likes = User.first.likes
    assert(likes.size == 1)
  end
end
