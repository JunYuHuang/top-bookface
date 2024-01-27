class LikesController < ApplicationController
  def create
    unless current_user.can_like_post?(create_param)
      redirect_to(
        root_path,
        status: 403,
        notice: "✋ Unauthorized to like post!"
      )
      return
    end

    @like = current_user.likes.build(post_id: create_param.to_i)

    if @like.save
      puts("Liked post #{@like}")
      redirect_back_or_to(
        post_path(create_param),
        status: 303,
        notice: "✅ Liked post"
      )
    else
      puts("Failed to like post #{@like}!")
      redirect_back_or_to(
        post_path(create_param),
        status: 422,
        notice: "💥 Failed to like post!"
      )
    end
  end

  def destroy
    unless current_user.can_unlike_post?(destroy_params)
      redirect_to(
        root_path,
        status: 403,
        notice: "✋ Unauthorized to unlike post!"
      )
      return
    end

    @like = Like.find_by(destroy_params)
    destroy_params => { post_id:, liker_id: }
    begin
      ActiveRecord::Base.transaction do
        res = ActiveRecord::Base.connection.execute(
          "DELETE FROM \"likes\" WHERE \"likes\".\"post_id\" = #{post_id} AND \"likes\".\"liker_id\" = #{liker_id}"
        )
        if !res.respond_to?(:cmdtuples) or res.cmdtuples != 1
          raise ActiveRecord::ActiveRecordError
        end
      end
    rescue ActiveRecord::ActiveRecordError
      puts("Failed to unlike post #{@like}!")
      redirect_back_or_to(
        post_path(@like.post_id),
        status: 422,
        notice: "💥 Failed to unlike post!"
      )
    else
      puts("Unliked post #{@like}!")
      redirect_back_or_to(
        post_path(@like.post_id),
        status: 303,
        notice: "✅ Unliked post"
      )
    end
  end

  private

  def create_param
    params.require(:post_id)
  end

  def destroy_params
    composite_pk = params.require(:id)
    post_id, liker_id = composite_pk.split("/")
    { post_id: post_id, liker_id: liker_id }
  end
end
