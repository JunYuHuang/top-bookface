class FollowsController < ApplicationController
  def index
    @followees = current_user.followees
    @followers = current_user.followers
  end

  def create
    # TODO
    @follow = Follow.new(create_follows_params)
    is_diff_user = @follow.followee_id != @follow.follower_id

    if is_diff_user && @follow.save
      # TODO - do nothing and refresh current page
      puts("Follow created!")
    else
      # TODO - display error message
      puts("Error creating follow!")
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    # TODO
    @follow = Follow.find(params[:id])
    @follow.destroy

    # TODO - do nothing and refresh current page
    puts("Deleted follow!")
  end

  private

  # TODO
  def create_follows_params
    params.require([:followee_id, :follower_id])
  end
end
