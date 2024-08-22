require 'rails_helper'

RSpec.describe 'Auth::LikesController', type: :request do
  let(:token) { 'valid_jwt_token' }
  let(:headers) { { Authorization: "Bearer #{token}" } }
  let(:user) { FactoryBot.create(:user) }
  let(:portfolio) { FactoryBot.create(:portfolio) }

  before do
    mock_auth(token:, auth0_id: user.auth0_id)
  end

  describe 'POST /auth/portfolios/:portfolio_id/likes' do
    context '「いいね」をしていない場合' do
      it '「いいね」を作成し、ステータス201を返す' do
        expect do
          post "/auth/portfolios/#{portfolio.id}/likes", headers:
        end.to change { portfolio.likes.reload.count }.by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context '既に「いいね」している場合' do
      before { portfolio.likes.create!(user:) }

      it '新しい「いいね」を作成せず、ステータス422を返す' do
        expect do
          post "/auth/portfolios/#{portfolio.id}/likes", headers:
        end.not_to(change { portfolio.likes.reload.count })

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /auth/portfolios/:portfolio_id/likes' do
    context '「いいね」が存在する場合' do
      before { portfolio.likes.create!(user:) }

      it '「いいね」を削除し、ステータス200を返す' do
        expect do
          delete "/auth/portfolios/#{portfolio.id}/likes", headers:
        end.to change { portfolio.likes.reload.count }.by(-1)

        expect(response).to have_http_status(:ok)
      end
    end

    context '「いいね」が存在しない場合' do
      it '「いいね」を削除せず、ステータス404を返す' do
        expect do
          delete "/auth/portfolios/#{portfolio.id}/likes", headers:
        end.not_to(change { portfolio.likes.reload.count })

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
