class CommentsController < ApplicationController
  # Dummy action handler to make Turbo work with non-GET request form submissions
  # Rail will throw a routing error if this path is not implemented or handled
  def index
    redirect_to post_path(params[:post_id])
  end

  # Dummy action handler to make Turbo work with non-GET request form submissions
  # Rail will throw a routing error if this path is not implemented or handled
  def show
    redirect_to post_path(params[:post_id])
  end

  def create
    @comment = Comment.new(
      post_id: params[:post_id],
      author_id: current_user.id,
      body: comment_params[:body]
    )

    unless @comment.valid?
      redirect_to(
        root_path,
        status: 400,
        notice: "❗ Invalid comment!"
      )
      return
    end

    if @comment.save
      puts("Created comment with id #{@comment.id}!")
      redirect_to(
        post_path(@comment.post_id),
        status: 201,
        notice: "✅ Added comment"
      )
    else
      puts("Failed to create comment with id #{@comment.id}!")
      redirect_to(
        post_path(@comment.post_id),
        status: 422,
        notice: "💥 Failed to add comment!"
      )
    end
  end

  def update
    @comment = Comment.find_by(
      id: params[:id],
      post_id: params[:post_id]
    )
    if @comment.nil?
      redirect_to(
        root_path,
        status: 404,
        notice: "❓ Comment not found"
      )
      return
    end

    unless current_user.is_comment_author?(@comment.id)
      redirect_back_or_to(
        post_path(@comment.post_id),
        status: 403,
        notice: "✋ Unauthorized to update post!"
      )
      return
    end

    if @comment.update(body: comment_params[:body])
      puts("Updated comment with id #{@comment.id}!")
      redirect_to(
        post_path(@comment.post_id),
        status: 201,
        notice: "✅ Updated comment"
      )
    else
      puts("Failed to update comment with id #{@comment.id}!")
      redirect_to(
        post_path(@comment.post_id),
        status: 422,
        notice: "💥 Failed to update comment!"
      )
    end
  end

  def edit
    @comment = Comment.find_by(
      id: params[:id],
      post_id: params[:post_id]
    )
    if @comment.nil?
      redirect_to(
        root_path,
        status: 404,
        notice: "❓ Comment not found"
      )
      return
    end

    unless current_user.is_comment_author?(@comment.id)
      redirect_back_or_to(
        post_comments_path(@comment.post_id),
        status: 403,
        notice: "✋ Unauthorized to edit post!"
      )
      return
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.nil?
      redirect_back_or_to(
        root_path,
        status: 404,
        notice: "❓ Comment not found"
      )
      return
    end

    unless current_user.is_comment_author?(@comment.id)
      redirect_back_or_to(
        post_comments_path(@comment.post_id),
        status: 403,
        notice: "✋ Unauthorized to delete post!"
      )
      return
    end

    if @comment.destroy
      puts("Deleted comment with id #{@comment.id}!")
      redirect_to(
        post_path(@comment.post_id),
        status: 201,
        notice: "✅ Deleted comment"
      )
    else
      puts("Failed to delete comment with id #{@comment.id}!")
      redirect_to(
        post_path(@comment.post_id),
        status: 422,
        notice: "💥 Failed to delete comment!"
      )
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
