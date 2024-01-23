class FollowRequestsController < ApplicationController
  def index
    unless current_user.can_view_follow_requests?(index_param)
      flash[:notice] = "✋ Unauthorized to view follow requests!"
      redirect_to root_path, status: 403
      return
    end

    @user = User.find(index_param)
    @received_requests = @user.received_follow_requests
  end

  def create
    create_params => { requestee_id:, requester_id: }
    unless current_user.can_send_follow_request_to?(requestee_id)
      redirect_to(
        root_path,
        status: 403,
        notice: "✋ Unauthorized to send follow request!"
      )
      return
    end

    @follow_request = FollowRequest.new(create_params)
    if @follow_request.save
      puts("Created follow request with id #{@follow_request.id}!")
      # TODO - make page refresh instead of redirecting to `/users/:user_id/follow_requests` page?
      redirect_back_or_to(
        root_path,
        status: 201,
        notice: "✅ Sent follow request"
      )
    else
      puts("Failed to create follow request with id #{@follow_request.id}!")
      redirect_back_or_to(
        root_path,
        status: 422,
        notice: "💥 Failed to send follow request!"
      )
    end
  end

  def destroy
    delete_params => { id:, is_accepted: }
    return unless FollowRequest.exists?(id: id)

    @follow_request = FollowRequest.find(id)
    is_following = Follow.where([
      "followee_id = :followee_id and follower_id = :follower_id",
      {
        followee_id: @follow_request.requestee_id,
        follower_id: @follow_request.requester_id
      }
    ]).exists?
    return if is_following

    # TODO - make accept request run as a SQL transaction to
    # create the follow and then delete the follow request
    if is_accepted
      @follow = Follow.new(
        followee_id: @follow_request.requestee_id,
        follower_id: @follow_request.requester_id
      )
      if @follow.save
        puts("Created follow with id #{@follow.id}!")
      else
        puts("Failed to create follow with id #{@follow.id}!")
        render :index, status: :unprocessable_entity
        return
      end
    end

    if @follow_request.destroy
      puts("Deleted follow request with id #{id}!")
      redirect_back_or_to root_path
    else
      puts("Failed to delete follow request with id #{@follow_request.id}!")
      render :index, status: :unprocessable_entity
    end
  end

  private

  def index_param
    params.require(:user_id)
  end

  def create_params
    user_id, requestee_id, requester_id = params.require(
      [:user_id, :requestee_id, :requester_id]
    )
    { requestee_id: requestee_id, requester_id: requester_id }
  end

  # use values "1" and "0" to represent boolean values true
  # and false for param `is_accepted` in the DELETE form
  def delete_params
    id, is_accepted = params.require([:id, :is_accepted])
    { id: id, is_accepted: is_accepted == "1"}
  end
end
