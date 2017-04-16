class AuthenticateUser
  def self.create_token(user)
    JsonWebToken.encode(user_id: user.id)
  end

  def initialize(email, password)
    @email = email
    @password = password
  end

  # Service entry point
  def call
    self.class.create_token(user) if user
  end

  private

  attr_reader :email, :password

  # verify user credentials
  def user
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)
    # raise Authentication error if credentials are invalid
    raise ExceptionHandler::AuthenticationError.new(Message.invalid_credentials)
  end
end
