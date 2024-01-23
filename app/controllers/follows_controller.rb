class FollowsController < ApplicationController
  def index
    @user = User.find(index_param)
    @followees = @user.followees
    @followers = @user.followers
  end

  # TODO - to test
  # For `Follow`s
  def create
    @follow = Follow.new(create_params)
    is_diff_user = @follow.followee_id != @follow.follower_id

    if is_diff_user && @follow.save
      puts("Created follow with id #{@follow.id}!")
      redirect_back_or_to root_path
    else
      puts("Failed to create follow with id #{@follow.id}!")
      render :index, status: :unprocessable_entity
    end
  end

  # For `Unfollow`s
  def destroy
    @follow = Follow.find(params[:id])
    if @follow.destroy
      puts("Deleted follow with id #{params[:id]}!")
      redirect_back_or_to root_path
      return
    end
    puts("Failed to delete follow with id #{params[:id]}")
  end

  private

  def index_param
    params.require(:user_id)
  end

  def create_params
    followee_id, follower_id = params.require(
      [:followee_id, :follower_id]
    )
    { followee_id: followee_id, follower_id: follower_id }
  end
end
