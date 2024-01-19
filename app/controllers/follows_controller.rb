class FollowsController < ApplicationController
  def index
    @followees = current_user.followees
    @followers = current_user.followers
  end

  def create
    @follow = Follow.new(create_follows_params)
    is_diff_user = @follow.followee_id != @follow.follower_id

    if is_diff_user && @follow.save
      puts("Created follow with id #{@follow.id}!")
      redirect_back_or_to root_path
    else
      puts("Failed to create follow with id #{@follow.id}!")
      render :index, status: :unprocessable_entity
    end
  end

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

  def create_follows_params
    followee_id, follower_id = params.require(
      [:followee_id, :follower_id]
    )
    { followee_id: followee_id, follower_id: follower_id }
  end
end
