class StarsController < ApplicationController
  before_action :authenticate_user

  def create
    star = Star.new star_params
    star.user = current_user
    star.post = post
    star.save
    redirect_to post_path(post)
  end

  def destroy
    post = star.post
    star.destroy
    redirect_to post_path(post)
  end

  def update
    post = star.post
    star.update star_params
    redirect_to post_path(post)
  end

  private

  def star_params
    params.require(:star).permit(:count)
  end

  def post
    @post ||= Post.find params[:post_id]
  end
  def star
    @star ||= Star.find params[:id]
  end
end
