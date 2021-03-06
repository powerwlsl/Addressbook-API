class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :update, :destroy]
  before_action :authorize_admin_request,only: [:create,:update,:destroy]
  # GET /organizations
  def index
    @organizations = Organization.all
    render json: @organizations, status: :ok
  end

  # POST /organizations
  def create
    @organization = Organization.create!(organization_params)
    render json: @organization, status: :created
  end

  # PUT /organizations/:id
  def update
    @organization.update(organization_params)
    head :no_content
  end

  # DELETE /organizations/:id
  def destroy
    @organization.destroy
    head :no_content
  end

  private

  def organization_params
    # whitelist params
    params.permit(:name)
  end

  def set_organization
    @organization = Organization.find(params[:id])
  end
end
