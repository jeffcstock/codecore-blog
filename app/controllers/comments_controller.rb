class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end
  def create
    @post = Post.find params[:post_id]
    comment_params = params.require(:comment).permit([:body, :post_id, :user_id])
    @comment = Comment.new comment_params
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post), notice: 'Comment created!'
    else
      render 'posts/show'
    end
  end
  def destroy
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to post_path(@post)
  end

end
