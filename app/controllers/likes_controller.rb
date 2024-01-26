class LikesController < ApplicationController
  def create
    unless current_user.can_like_post?(like_param)
      redirect_to(
        root_path,
        status: 403,
        notice: "✋ Unauthorized to like post!"
      )
      return
    end

    @like = current_user.likes.build(post_id: like_param.to_i)

    if @like.save
      puts("Liked post #{@like}")
      redirect_back_or_to(
        post_path(like_param),
        status: 303,
        notice: "✅ Liked post"
      )
    else
      puts("Failed to liked post #{@like}!")
      redirect_back_or_to(
        post_path(like_param),
        status: 422,
        notice: "💥 Failed to like post!"
      )
    end
  end

  def destroy
    # TODO
  end

  private

  def like_param
    params.require(:post_id)
  end
end
