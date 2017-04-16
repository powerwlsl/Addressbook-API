class AuthenticationController < ApplicationController
  # return auth token once user is authenticated
  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    render json: {auth_token: auth_token}
  end

  private

  def auth_params
    params.permit(:email, :password)
  end

end
