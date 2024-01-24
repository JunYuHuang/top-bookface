class FollowRequestsController < ApplicationController
  def index
    unless current_user.can_view_follow_requests?(index_param)
      redirect_to(
        root_path,
        status: 403,
        notice: "✋ Unauthorized to view follow requests!"
      )
      return
    end

    @user = User.find(index_param)
    @sent_requests = @user.sent_follow_requests
    @received_requests = @user.received_follow_requests
  end

  # Send follow request
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

  # Reject follow request
  def destroy
    # TODO - to test
    unless current_user.can_reject_follow_request?(destroy_params)
      redirect_to(
        root_path,
        status: 403,
        notice: "✋ Unauthorized to reject follow request!"
      )
      return
    end

    @follow_request = FollowRequest.find_by(destroy_params)
    if @follow_request.destroy
      puts("Deleted follow request with id #{@follow_request.id}!")
      redirect_back_or_to(
        root_path,
        status: 303,
        notice: "✅ Rejected follow request"
      )
    # TODO - to test
    else
      puts("Failed to delete follow request with id #{@follow_request.id}!")
      redirect_back_or_to(
        root_path,
        status: 422,
        notice: "💥 Failed to reject follow request!"
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
    create_params
  end
end
