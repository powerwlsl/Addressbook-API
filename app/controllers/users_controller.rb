class UsersController < ApplicationController
  # POST /signup
  # return authenticated token upon signup
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    render json: response, status: :created
  end
  
  private

  def user_params
    params.permit(
      :email,
      :password,
      :password_confirmation,
      :organization_ids
    )
  end
end
