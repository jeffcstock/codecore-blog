class FavouritesController < ApplicationController
  before_action :authenticate_user

  def create
    @post = Post.find params[:post_id]
    @favourite = Favourite.new(user: current_user, post: @post)
    respond_to do |format|
      if cannot? :favourite, @post
        format.html {redirect_to :back, notice: '❌Access denied❌'}
      elsif @favourite.save
        format.js { render :favourite_success }
        format.html {redirect_to :back}
      else
        format.html {redirect_to :back}
      end
    end
  end

  def destroy
    favourite = Favourite.find params[:id]
    # question = favourite.question
    @post = favourite.post
    respond_to do |format|
      if favourite.destroy
        format.html {redirect_to :back }
        format.js { render :favourite_success }
      else
        format.html {redirect_to :back, alert: favourite.errors.full_messages.join(", ")}
        format.js { render :favourite_failure }
      end
    end
  end
end
