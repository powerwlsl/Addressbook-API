class OrganizationsUsersController < ApplicationController
  before_action :authorize_request

  def index
    @organization = Organization.find(params[:organization_id])
    unless current_user.member?(@organization)
      raise ExceptionHandler::AuthenticationError.new(Message.unauthorized)
    else
      render json: @organization.users, status: :ok
    end
  end
end