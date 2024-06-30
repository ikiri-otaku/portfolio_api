require 'jwt'
require 'net/http'

class Auth0Client
  # Auth0 Client Objects
  Error = Struct.new(:message, :status)
  Response = Struct.new(:decoded_token, :error)

  # Token Validation
  def self.validate_token(token) # rubocop:disable Metrics/AbcSize
    jwks_response = jwks

    unless jwks_response.is_a? Net::HTTPSuccess
      error = Error.new(message: I18n.t('errors.messages.unable_to_verify_credentials'), status: :internal_server_error)
      return Response.new(nil, error)
    end

    jwks_hash = JSON.parse(jwks_response.body).deep_symbolize_keys

    decoded_token = decode_token(token, jwks_hash)

    Response.new(decoded_token, nil)
  rescue JWT::VerificationError, JWT::DecodeError => e
    Rails.logger.error "Auth0ClientInvalidTokenError: #{e.inspect}"
    error = Error.new(I18n.t('errors.messages.invalid_token'), :unauthorized)
    Response.new(nil, error)
  end

  def self.jwks
    jwks_uri = URI("#{domain_url}.well-known/jwks.json")
    Net::HTTP.get_response jwks_uri
  end

  # Helper Functions
  def self.domain_url
    "https://#{Rails.configuration.auth0.domain}/"
  end

  def self.decode_token(token, jwks_hash)
    JWT.decode(token, nil, true,
      {
        algorithm: 'RS256',
        iss: domain_url,
        verify_iss: true,
        aud: Rails.configuration.auth0.audience.to_s,
        verify_aud: true,
        jwks: { keys: jwks_hash[:keys] }
      })
  end
end
