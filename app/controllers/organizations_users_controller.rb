class OrganizationsUsersController < ApplicationController
  before_action :authorize_request
  before_action :set_organization
  def index
    unless current_user.member?(@organization)
      raise ExceptionHandler::AuthenticationError.new(Message.unauthorized)
    else
      render json: @organization.users, status: :ok
    end
  end

  def create
    @organization_user = current_user.organizations_users.create(organization_id: @organization.id)
    render json: @organization_user , status: :created
  end

  def destroy
    current_user.organizations_users.find_by(organization_id: @organization.id).destroy
    head :no_content
  end

  private

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end
end