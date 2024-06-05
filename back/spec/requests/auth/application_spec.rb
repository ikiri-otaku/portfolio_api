require 'rails_helper'

RSpec.describe 'Auth::Application', type: :request do
  include MockAuth0Client

  describe '#authorize' do
    let(:token) { 'valid_jwt_token' }
    let(:headers) { { Authorization: "Bearer #{token}" } }

    it 'Authorizationヘッダがない場合、401を返す' do
      post auth_user_path
      expect(response).to have_http_status :unauthorized
      json = response.parsed_body
      expect(json['message']).to eq 'Requires authentication'
    end

    it 'Authorizationヘッダが空の場合、401を返す' do
      post auth_user_path, headers: { Authorization: '' }
      expect(response).to have_http_status :unauthorized
      json = response.parsed_body
      expect(json['message']).to eq 'Bad credentials'
      expect(json['error']).to eq 'invalid_request'
    end

    it 'Authorizationヘッダが不正の場合、401を返す' do
      post auth_user_path, headers: { Authorization: 'rabbit token' }
      expect(response).to have_http_status :unauthorized
      json = response.parsed_body
      expect(json['message']).to eq 'Bad credentials'
      expect(json['error']).to be nil
    end

    it 'jwksのリクエストに失敗した場合、500を返す' do
      stub_jwks_request_failure

      post auth_user_path, headers:, params: {}
      expect(response).to have_http_status :internal_server_error
      json = response.parsed_body
      expect(json['message']).to eq 'Unable to verify credentials'
    end

    it 'JWTが不正の場合、401を返す' do
      allow(Rails.logger).to receive(:error)
      stub_jwks_request
      stub_unverified_token

      post auth_user_path, headers:, params: {}
      expect(response).to have_http_status :unauthorized
      json = response.parsed_body
      expect(json['message']).to eq 'Bad credentials'
      expect(Rails.logger).to have_received(:error).with(/InvalidTokenError/)
    end
  end
end
