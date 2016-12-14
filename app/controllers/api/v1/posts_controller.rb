class Api::V1::PostsController < Api::BaseController

  def index
    posts = Post.order(created_at: :desc)
    render json: posts
  end
end
