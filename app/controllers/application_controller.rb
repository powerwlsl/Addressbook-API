class ApplicationController < ActionController::API
  include ExceptionHandler


  attr_reader :current_user

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end

  def authorize_admin_request
    authorize_request
    unless current_user.admin?
      raise ExceptionHandler::AuthenticationError.new(Message.unauthorized)
    end
  end
end
