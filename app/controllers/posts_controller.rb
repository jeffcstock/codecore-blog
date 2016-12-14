class PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :can_edit?, only: [:edit, :update, :destroy]
  before_action :set_page, only: [:index]

  POSTS_PER_PAGE = 10

  def index
    @post = Post.order(created_at: :desc).limit(POSTS_PER_PAGE).offset(@page.to_i * POSTS_PER_PAGE)
    @posts = Post.search(params[:search])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @fav = @post.fav_for(current_user)
  end

  def edit
  end

  def update
    if @post.update post_params
      redirect_to post_path(@post), notice: 'Post updated! ✔️'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def set_page
    @page = params[:page] || 0
  end

  def post_params
    post_params = params.require(:post).permit([:title, :body, :user_id, tag_ids: []])
  end

  def find_post
    @post = Post.find params[:id]
  end

  def can_edit?
    redirect_to root_path, alert: "access defined" unless can? :edit, @post
  end

end
