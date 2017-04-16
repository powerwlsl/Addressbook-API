module ExceptionHandler
  extend ActiveSupport::Concern
  
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end


  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight
    
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: e.message, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: e.message, status: :unprocessable_entity
    end
  end

  # JSON response with message; Status code 422 - unprocessable entity
  def four_twenty_two(e)
    render json: e.message, status: :unprocessable_entity
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(e)
    render json: e.message, status: :unauthorized
  end

  # JSON response with message; Status code 498 - Invalid Token
  def four_ninety_eight(e)
    render json: e.message, status: :invalid_token
  end
end