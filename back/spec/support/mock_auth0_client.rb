require 'jwt'
require_relative '../../app/lib/auth0_client'

module MockAuth0Client
  @@jwks_url = "#{Auth0Client.domain_url}.well-known/jwks.json" # rubocop:disable Style/ClassVars
  @@jwks_response_body = { # rubocop:disable Style/ClassVars
    keys: [
      {
        kty: 'RSA',
        kid: 'testkid1',
        use: 'sig',
        n: 'example',
        e: 'AQAB'
      }
    ]
  }.to_json

  attr_reader :jwks_url, :jwks_response_body

  def mock_auth(token: 'valid_jwt_token', auth0_id: 'anonymous')
    stub_jwks_request
    stub_decode_token(token:, decoded_payload: { sub: auth0_id })
  end

  def mock_auth_invlid
    stub_jwks_request
    stub_unverified_token
  end

  def stub_jwks_request
    response = instance_double(Net::HTTPSuccess, body: @@jwks_response_body, is_a?: true)
    allow(Net::HTTP).to receive(:get_response).with(URI(@@jwks_url)).and_return(response)
  end

  def stub_jwks_request_failure
    response = instance_double(Net::HTTPInternalServerError)
    allow(Net::HTTP).to receive(:get_response).with(URI(@@jwks_url)).and_return(response)
  end

  def stub_decode_token(token: 'valid_jwt_token', decoded_payload: { sub: 'auth0_id' })
    jwks_hash = JSON.parse(@@jwks_response_body, symbolize_names: true)

    allow(JWT).to receive(:decode).with(token, nil, true, hash_including(jwks: { keys: jwks_hash[:keys] }))
      .and_return([decoded_payload])
  end

  def stub_unverified_token
    allow(Auth0Client).to receive(:decode_token).and_raise(JWT::DecodeError)
  end
end
