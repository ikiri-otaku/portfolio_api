class Auth::ApplicationController < ApplicationController
  before_action :authorize

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

    render json: { message: I18n.t('errors.messages.requires_authentication') }, status: :unauthorized and return unless authorization_header_elements

    unless authorization_header_elements.length == 2
      render json: { message: I18n.t('errors.messages.malformed_authorization_header') },
        status: :unauthorized and return
    end

    scheme, token = authorization_header_elements

    render json: { message: I18n.t('errors.messages.bad_credentials') }, status: :unauthorized and return unless scheme.downcase == 'bearer'

    token
  end
end
