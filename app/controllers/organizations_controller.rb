class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :update, :destroy]

  # GET /organizations
  def index
    @organizations = Organization.all
    render json: @organization, status: :ok
  end

  # POST /organizations
  def create
    @organization = Organization.create!(organization_params)
    render json: @organization, status: :created
  end

  # GET /organizations/:id
  def show
    render json: @organization, status: :ok
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
    params.permit(:title, :created_by)
  end

  def set_organization
    @organization = Organization.find(params[:id])
  end
end
