require 'rails_helper'

RSpec.describe 'Auth::Users', type: :request do
  let(:token) { 'valid_jwt_token' }
  let(:headers) { { Authorization: "Bearer #{token}" } }

  describe 'POST   /auth/user' do
    context '不正なアクセストークンの場合' do
      it '404を返す' do
        mock_auth_invlid

        post auth_user_path, headers:, params: {}
        expect(response).to have_http_status :unauthorized
      end
    end

    context '正統なアクセスの場合' do
      it 'ユーザ作成済の場合、ユーザを作成せず200を返す' do
        user = FactoryBot.create(:user)
        mock_auth(token:, auth0_id: user.auth0_id)

        post auth_user_path, headers:, params: { user: { auth0_id: user.auth0_id } }
        expect(response).to have_http_status :ok
        expect(User.count).to eq 1
      end

      it 'ユーザ未作成の場合、ユーザを作成して200を返す' do
        mock_auth
        post auth_user_path, headers:, params: { user: { name: 'name', github_username: 'github_username', auth0_id: 'auth0_id' } }

        expect(response).to have_http_status(200)

        user = User.last
        expect(user.name).to eq 'name'
        expect(user.github_username).to eq 'github_username'
        expect(user.auth0_id).to eq 'auth0_id'
      end

      it 'ユーザ作成が失敗した場合、500を返す' do
        allow(Rails.logger).to receive(:error)
        mock_auth

        post auth_user_path, headers:, params: { user: { name: 'name', github_username: 'github_username' } } # auth0_idの必須エラーにする

        expect(response).to have_http_status :unprocessable_entity
        expect(Rails.logger).to have_received(:error).with(/UserCreateFailed/)
        expect(User.count).to eq 0
      end
    end
  end

  # TODO: describe 'DELETE /auth/user'
end
