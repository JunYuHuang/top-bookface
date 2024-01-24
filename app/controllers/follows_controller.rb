class FollowsController < ApplicationController
  def index
    @user = User.find(index_param)
    @followees = @user.followees
    @followers = @user.followers
  end

  # Delete follow request and create a follow
  def create
    # TODO - to test
    unless current_user.can_accept_follow_request?(create_params)
      redirect_to(
        root_path,
        status: 403,
        notice: "✋ Unauthorized to accept follow request!"
      )
      return
    end

    follow = nil
    follow_request = FollowRequest.find_by(create_params)
    create_params => { requestee_id:, requester_id: }
    begin
      ActiveRecord::Base.transaction do
        follow = Follow.create!(
          followee_id: requestee_id, follower_id: requester_id
        )
        follow_request.destroy!
      end
    rescue ActiveRecord::RecordNotSaved
      puts("Failed to create follow with id #{follow.id}!")
      redirect_back_or_to(
        root_path,
        status: 422,
        notice: "💥 Failed to create follow!"
      )
    rescue ActiveRecord::RecordNotDestroyed
      puts("Failed to delete follow request with id #{follow_request.id}!")
      redirect_back_or_to(
        root_path,
        status: 422,
        notice: "💥 Failed to accept follow from '#{follow_request.requester.username}'!"
      )
    else
      puts("Created follow and deleted follow request!")
      redirect_back_or_to(
        root_path,
        status: 303,
        notice: "✅ Accepted follow request from '#{follow.follower.username}'"
      )
    end
  end

  # For `Unfollow`s
  def destroy
    # TODO - to test
    unless current_user.can_unfollow?(destroy_params)
      redirect_to(
        root_path,
        status: 403,
        notice: "✋ Unauthorized to unfollow!"
      )
      return
    end

    @follow = Follow.find_by(destroy_params)
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
    requestee_id, requester_id = params.require(
      [:requestee_id, :requester_id]
    )
    { requestee_id: requestee_id, requester_id: requester_id }
  end

  def destroy_params
    followee_id, follower_id = params.require(
      [:followee_id, :follower_id]
    )
    { followee_id: followee_id, follower_id: follower_id }
  end
end
