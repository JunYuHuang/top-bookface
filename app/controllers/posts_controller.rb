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
  end

  def new
  end

  def update
  end

  def edit
  end

  def destroy
  end
end
