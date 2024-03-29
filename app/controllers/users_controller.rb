class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:sign_in, :sign_up]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @is_same_user = current_user.is_same_user?(@user.id)
    @can_follow = current_user.can_send_follow_request?(
      { requestee_id: @user.id, requester_id: current_user.id }
    )
    @can_unfollow = current_user.can_unfollow?(
      { followee_id: @user.id, follower_id: current_user.id }
    )
    @follower_count = @user.followers.count
    @followee_count = @user.followees.count
    @post_count = @user.posts.count
    @posts = @user.posts
  end
end
