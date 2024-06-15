class Auth::ApplicationController < ApplicationController
  before_action :authorize

  REQUIRES_AUTHENTICATION = { message: 'Requires authentication' }.freeze
  BAD_CREDENTIALS = { message: 'Bad credentials' }.freeze
  MALFORMED_AUTHORIZATION_HEADER = {
    error: 'invalid_request',
    error_description: 'Authorization header value must follow this format: Bearer access-token',
    message: 'Bad credentials'
  }.freeze

  attr_reader :current_user

  private

  def authorize
    token = token_from_request

    return if performed?

    validation_response = Auth0Client.validate_token(token)

    if (error = validation_response.error)
      render json: { message: error.message }, status: error.status
    else
      auth0_id = validation_response.decoded_token.first[:sub]
      @current_user ||= User.find_by(auth0_id:) if auth0_id
    end
  end

  def token_from_request
    authorization_header_elements = request.headers['Authorization']&.split

    render json: REQUIRES_AUTHENTICATION, status: :unauthorized and return unless authorization_header_elements

    render json: MALFORMED_AUTHORIZATION_HEADER, status: :unauthorized and return unless authorization_header_elements.length == 2

    scheme, token = authorization_header_elements

    render json: BAD_CREDENTIALS, status: :unauthorized and return unless scheme.downcase == 'bearer'

    token
  end
end
