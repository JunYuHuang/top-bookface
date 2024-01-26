class LikesController < ApplicationController
  def create
    # TODO
  end

  def destroy
    # TODO
  end

  private

  def like_params
    params.require([:post_id, :liker_id])
    { post_id: post_id, liker_id: liker_id }
  end
end
