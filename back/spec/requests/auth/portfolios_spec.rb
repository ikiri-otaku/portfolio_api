require 'rails_helper'

RSpec.describe 'Auth::Portfolios', type: :request do
  let(:token) { 'valid_jwt_token' }
  let(:headers) { { Authorization: "Bearer #{token}" } }
  let(:user) { FactoryBot.create(:user) }
  let(:url) { 'http://example.com' }

  describe 'POST   /auth/portfolios' do
    describe '正常系' do
      before do
        mock_auth(token:, auth0_id: user.auth0_id)
        allow_any_instance_of(Octokit::Client).to receive(:repository?).and_return(true)
        allow_any_instance_of(Octokit::Client).to receive(:collaborator?).and_return(true)
        health_check_response = instance_double(Net::HTTPSuccess)
        allow(health_check_response).to receive(:is_a?).with(Net::HTTPSuccess).and_return(true)
        allow(Net::HTTP).to receive(:get_response).with(URI.parse(url)).and_return(health_check_response)
      end

      it '正常なパラメータの場合、ポートフォリオを作成し、201を返す' do
        expect(Organization.count).to eq 0
        expect(Portfolio.count).to eq 0

        post auth_portfolios_path, headers:, params: { portfolio: { name: 'アプリ名', url:, introduction: 'アプリ説明文', github_url: "https://example.github.com/#{user.github_username}/repo" } }
        expect(response).to have_http_status :created

        portfolio = user.reload.portfolios.first
        expect(portfolio.user_id).to eq user.id
        expect(portfolio.organization_id).to be nil
        expect(portfolio.name).to eq 'アプリ名'
        expect(portfolio.url).to eq 'http://example.com'
        expect(portfolio.introduction).to eq 'アプリ説明文'
        expect(portfolio.unhealthy_cnt).to eq 0
        expect(portfolio.latest_health_check_time).not_to be nil
      end
    end

    describe '異常系' do
      context '不正なアクセストークンの場合' do
        it '401を返す' do
          mock_auth_invlid

          post auth_portfolios_path, headers:, params: {}
          expect(response).to have_http_status :unauthorized
        end
      end
      context 'GitHubが例外を返す場合' do
        before do
          mock_auth(token:, auth0_id: user.auth0_id)
          allow(Rails.logger).to receive(:error)
        end
        it 'Unauthorizedが返ってきた場合、保存処理を中断し、500を返すこと' do
          allow_any_instance_of(Octokit::Client).to receive(:repository?).and_raise(Octokit::Unauthorized)

          post auth_portfolios_path, headers:, params: { portfolio: { name: 'アプリ名', url:, introduction: 'アプリ説明文', github_url: "https://example.github.com/#{user.github_username}/repo" } }
          expect(response).to have_http_status :internal_server_error

          expect(Portfolio.count).to eq 0
          expect(Rails.logger).to have_received(:error).with('#<GithubClient::Error: Unauthorized: Please check your GitHub token.>')
        end
        it 'Forbiddenが返ってきた場合、保存処理を中断し、500を返すこと' do
          allow_any_instance_of(Octokit::Client).to receive(:repository?).and_raise(Octokit::Forbidden)

          post auth_portfolios_path, headers:, params: { portfolio: { name: 'アプリ名', url:, introduction: 'アプリ説明文', github_url: "https://example.github.com/#{user.github_username}/repo" } }
          expect(response).to have_http_status :internal_server_error

          expect(Portfolio.count).to eq 0
          expect(Rails.logger).to have_received(:error).with('#<GithubClient::Error: Forbidden: You do not have permission to access this resource.>')
        end
        it 'TooManyRequestsが返ってきた場合、保存処理を中断し、500を返すこと' do
          allow_any_instance_of(Octokit::Client).to receive(:repository?).and_raise(Octokit::TooManyRequests)

          post auth_portfolios_path, headers:, params: { portfolio: { name: 'アプリ名', url:, introduction: 'アプリ説明文', github_url: "https://example.github.com/#{user.github_username}/repo" } }
          expect(response).to have_http_status :internal_server_error

          expect(Portfolio.count).to eq 0
          expect(Rails.logger).to have_received(:error).with('#<GithubClient::Error: Rate limit exceeded: Please wait before making more requests.>')
        end
        it 'その他のエラーが返ってきた場合、保存処理を中断し、500を返すこと' do
          allow_any_instance_of(Octokit::Client).to receive(:repository?).and_raise(Octokit::Error)

          post auth_portfolios_path, headers:, params: { portfolio: { name: 'アプリ名', url:, introduction: 'アプリ説明文', github_url: "https://example.github.com/#{user.github_username}/repo" } }
          expect(response).to have_http_status :internal_server_error

          expect(Portfolio.count).to eq 0
          expect(Rails.logger).to have_received(:error).with('#<GithubClient::Error: An error occurred: Octokit::Error>')
        end
      end
    end
  end
  describe 'PATCH  /auth/portfolios' do
    # TODO
  end
  describe 'DELETE /auth/portfolios' do
    # TODO
  end
end
