class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    unless Post.exists?(params[:id])
      redirect_to(
        root_path,
        status: 404,
        notice: "❓ Post not found"
      )
      return
    end

    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(create_params)

    if @post.save
      redirect_to(
        post_path(@post.id),
        status: 303,
        notice: "✅ Created post"
      )
    else
      flash.now[:notice] = "💥 Failed to create post!"
      render :new, status: 422
    end
  end

  def new
    @post = Post.new
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private

  def create_params
    params.require(:post).permit(:body)
  end
end
