class CommentsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]


  def new
    @comment = Comment.new
  end
  def create
    @post = Post.find params[:post_id]
    comment_params = params.require(:comment).permit([:body, :post_id, :user_id])
    @comment = Comment.new comment_params
    @comment.post = @post
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html {redirect_to post_path(@post)}
        format.js {render :create_comment_success}
      else
        format.html {render 'posts/show'}
        format.js {render :create_comment_failure}
      end
    end
  end

  def destroy
    post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
    respond_to do |format|
      if can? :delete, @comment
        @comment.destroy
        format.html {redirect_to post}
        format.js { render }
      else
        format.html {redirect_to root_path, notice: 'Access Denied.'}
        format.js {render js: "alert('Access denied');"}
      end
    end
  end

  private

end
