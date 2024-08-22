require 'rails_helper'

RSpec.describe 'Auth::LikesController', type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:portfolio) { FactoryBot.create(:portfolio) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'POST #create' do
    context '「いいね」をしていない場合' do
      it '「いいね」を作成し、ステータス201を返す' do
        expect {
          post :create, params: { portfolio_id: portfolio.id }
        }.to change(portfolio.likes, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to eq('「いいね」しました')
      end
    end

    context '既に「いいね」している場合' do
      before { portfolio.likes.create!(user: user) }

      it '新しい「いいね」を作成せず、ステータス422を返す' do
        expect {
          post :create, params: { portfolio_id: portfolio.id }
        }.not_to change(portfolio.likes, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message']).to eq('既に「いいね」されています')
      end
    end
  end

  describe 'DELETE #destroy' do
    context '「いいね」が存在する場合' do
      before { portfolio.likes.create!(user: user) }

      it '「いいね」を削除し、ステータス200を返す' do
        expect {
          delete :destroy, params: { portfolio_id: portfolio.id }
        }.to change(portfolio.likes, :count).by(-1)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('「いいね」を取り消しました')
      end
    end

    context '「いいね」が存在しない場合' do
      it '「いいね」を削除せず、ステータス404を返す' do
        expect {
          delete :destroy, params: { portfolio_id: portfolio.id }
        }.not_to change(portfolio.likes, :count)

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('「いいね」が見つかりません')
      end
    end
  end
end