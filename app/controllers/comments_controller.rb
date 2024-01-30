class CommentsController < ApplicationController
  def index
    redirect_to post_path(params[:post_id])
  end

  def create
    @comment = Comment.new(
      post_id: params[:post_id],
      author_id: current_user.id,
      body: create_param[:body]
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
  end

  def edit
  end

  def destroy
  end

  private

  def create_param
    params.require(:comment).permit(:body)
  end
end
