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
    # TODO - to test
    unless current_user.can_unfollow?(delete_params)
      redirect_to(
        root_path,
        status: 403,
        notice: "✋ Unauthorized to unfollow!"
      )
      return
    end

    @follow = Follow.find_by(delete_params)
    if @follow.destroy
      puts("Deleted follow with id #{@follow.id}!")
      redirect_back_or_to(
        root_path,
        status: 303,
        notice: "✅ Unfollowed '#{@follow.followee.username}'"
      )
    # TODO - to test
    else
      puts("Failed to delete follow with id #{@follow.id}!")
      redirect_back_or_to(
        root_path,
        status: 422,
        notice: "💥 Failed to unfollow '#{@follow.followee.username}'!"
      )
    end
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

  def delete_params
    create_params
  end
end
