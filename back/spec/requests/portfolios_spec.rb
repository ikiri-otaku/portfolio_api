require 'rails_helper'

RSpec.describe 'Portfolios', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:organization) { FactoryBot.create(:organization, :with_my_user, my_user: user, github_username: 'github-organization') }
  describe 'GET    /portfolios/:id' do
    describe '正常系' do
      let(:portfolio_all_fields) { FactoryBot.create(:portfolio, user:, organization:, created_at: '2020-01-05 09:30:00', github_url: "https://example.github.com/#{organization.github_username}/repo") }
      let(:portfolio_required_fields) { FactoryBot.create(:portfolio, :required_fields, user:, created_at: '2020-01-05 09:30:00') }
      it '必須項目のみ登録したデータを返す場合、nilの項目は空文字で返す' do
        get portfolio_path(portfolio_required_fields)
        expect(response).to have_http_status :ok

        json = response.parsed_body
        expect(json['name']).to eq portfolio_required_fields.name
        expect(json['url']).to eq portfolio_required_fields.url
        expect(json['introduction']).to be nil
        expect(json['created_date']).to eq '2020/01/05'
        expect(json['creator']).to eq user.name
      end
      it '全項目を登録したデータを返す場合、整形して返す' do
        get portfolio_path(portfolio_all_fields)
        expect(response).to have_http_status :ok

        json = response.parsed_body
        expect(json['name']).to eq portfolio_all_fields.name
        expect(json['url']).to eq portfolio_all_fields.url
        expect(json['introduction']).to eq 'This is a sample portfolio introduction.'
        expect(json['created_date']).to eq '2020/01/05'
        expect(json['creator']).to eq organization.name
      end
    end
    describe '異常系' do
      it '存在しないidを指定した場合、404を返す' do
        get portfolio_path(0)
        expect(response).to have_http_status :not_found
      end
    end
  end
end
