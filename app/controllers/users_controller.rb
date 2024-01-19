class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:sign_in, :sign_up]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @is_same_user = @user.id == current_user.id
    @is_following = @user.followers.exists?(id: current_user.id)
    @follow = @user.followee_follows
      .where([
        "follower_id = :follower_id",
        { follower_id: current_user.id }
      ])
  end
end
