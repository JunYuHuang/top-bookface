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
    @can_edit = current_user.can_edit_post?(params[:id])
    @can_delete = current_user.can_delete_post?(params[:id])
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
    unless current_user.can_edit_post?(params[:id])
      redirect_to(
        root_path,
        status: 403,
        notice: "✋ Unauthorized to edit post!"
      )
      return
    end

    @post = Post.find(params[:id])

    if @post.update(update_params)
      redirect_to(
        post_path(@post.id),
        status: 303,
        notice: "✅ Updated post"
      )
    else
      flash.now[:notice] = "💥 Failed to update post!"
      render :edit, status: 422
    end
  end

  def edit
    unless current_user.can_edit_post?(params[:id])
      redirect_to(
        root_path,
        status: 403,
        notice: "✋ Unauthorized to edit post!"
      )
      return
    end

    @post = Post.find(params[:id])
  end

  def destroy
    unless current_user.can_delete_post?(params[:id])
      redirect_to(
        root_path,
        status: 403,
        notice: "✋ Unauthorized to delete post!"
      )
      return
    end

    @post = Post.find(params[:id])

    if @post.destroy
      redirect_to(
        posts_path,
        status: 303,
        notice: "✅ Deleted post"
      )
    else
      flash.now[:notice] = "💥 Failed to delete post!"
      render :show, status: 422
    end
  end

  private

  def create_params
    params.require(:post).permit(:body)
  end

  def update_params
    create_params
  end
end
