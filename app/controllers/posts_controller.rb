class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @post = Post.order(created_at: :desc).limit(POSTS_PER_PAGE).offset(@page.to_i * POSTS_PER_PAGE)
    @posts = Post.search(params[:search])
  end
  before_action :set_page, only: [:index]
    POSTS_PER_PAGE = 10

  def new
    @post = Post.new
  end

  def create
    post_params = params.require(:post).permit([:title, :body, :user_id])
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find params[:id]
    @comment = Comment.new
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    post_params = params.require(:post).permit(:title, :body)
    if @post.update post_params
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find params[:id]
    @post.destroy
    redirect_to posts_path
  end

  private

  def set_page
    @page = params[:page] || 0
  end

end
