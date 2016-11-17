class Api::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  # before_action :authenticate
  #
  # def authenticate
  #   @api_user = User.find_by_api_key params[:api_key]
  #   head :unauthorized unless @api_user
  # end
end
