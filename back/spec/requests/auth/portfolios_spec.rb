require 'rails_helper'

RSpec.describe 'Auth::Portfolios', type: :request do
  let(:token) { 'valid_jwt_token' }
  let(:headers) { { Authorization: "Bearer #{token}" } }
  let(:user) { FactoryBot.create(:user) }
  let(:organization) { FactoryBot.create(:organization, :with_my_user, my_user: user, github_username: 'github-organization') }
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

      it '必須項目のみパラメータで渡した場合、ポートフォリオを作成し、201を返す' do
        expect(Organization.count).to eq 0
        expect(Portfolio.count).to eq 0
        expect(GithubRepository.count).to eq 0

        post auth_portfolios_path, headers:, params: { portfolio: { name: 'アプリ名', url: } }
        expect(response).to have_http_status :created

        portfolio = user.reload.portfolios.first
        expect(portfolio.user_id).to eq user.id
        expect(portfolio.organization_id).to be nil
        expect(portfolio.name).to eq 'アプリ名'
        expect(portfolio.url).to eq 'http://example.com'
        expect(portfolio.introduction).to be nil
        expect(portfolio.unhealthy_cnt).to eq 0
        expect(portfolio.latest_health_check_time).not_to be nil
        expect(portfolio.github_repository).to be nil
      end

      it '全項目をパラメータで渡した場合、ポートフォリオを作成し、201を返す' do
        expect(Organization.count).to eq 0
        expect(Portfolio.count).to eq 0
        expect(GithubRepository.count).to eq 0

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
        expect(portfolio.github_repository.owner).to eq user.github_username
        expect(portfolio.github_repository.repo).to eq 'repo'
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
      context 'repositoryのownerでもcollaboratorでもない場合' do
        it '422を返す' do
          mock_auth(token:, auth0_id: user.auth0_id)
          allow_any_instance_of(Octokit::Client).to receive(:collaborator?).and_return(false)

          post auth_portfolios_path, headers:, params: { portfolio: { name: 'アプリ名', url:, introduction: 'アプリ説明文', github_url: 'https://example.github.com/team/repo' } }
          expect(response).to have_http_status :unprocessable_entity
        end
      end
    end
  end

  describe 'PATCH  /auth/portfolios' do
    before do
      mock_auth(token:, auth0_id: user.auth0_id)
      allow_any_instance_of(Octokit::Client).to receive(:repository?).and_return(true)
      allow_any_instance_of(Octokit::Client).to receive(:collaborator?).and_return(true)
      health_check_response = instance_double(Net::HTTPSuccess)
      allow(health_check_response).to receive(:is_a?).with(Net::HTTPSuccess).and_return(true)
      allow(Net::HTTP).to receive(:get_response).with(URI.parse(url)).and_return(health_check_response)
    end

    describe '正常系' do
      let(:portfolio_all_fields) { FactoryBot.create(:portfolio, user:, organization:, github_url: "https://example.github.com/#{organization.github_username}/repo") }
      let(:portfolio_required_fields) { FactoryBot.create(:portfolio, :required_fields, user:) }
      it '必須項目のみパラメータで渡した場合、ポートフォリオを更新し、201を返す' do
        patch auth_portfolio_path(portfolio_all_fields), headers:, params: { portfolio: { name: 'アプリ名更新', url: 'http://example.com/update' } }

        expect(response).to have_http_status :created

        portfolio_all_fields.reload
        expect(portfolio_all_fields.user_id).to eq user.id
        expect(portfolio_all_fields.organization_id).to eq organization.id
        expect(portfolio_all_fields.name).to eq 'アプリ名更新'
        expect(portfolio_all_fields.url).to eq 'http://example.com/update'
        expect(portfolio_all_fields.introduction).to eq 'This is a sample portfolio introduction.'
        expect(portfolio_all_fields.github_repository.owner).to eq organization.github_username
        expect(portfolio_all_fields.github_repository.repo).to eq 'repo'
      end
      it '必須項目以外空でパラメータで渡した場合、ポートフォリオを更新し、201を返す' do
        patch auth_portfolio_path(portfolio_all_fields), headers:, params: { portfolio: { name: 'アプリ名更新', url: 'http://example.com/update', introduction: '', github_url: '' } }

        expect(response).to have_http_status :created

        portfolio_all_fields.reload
        expect(portfolio_all_fields.user_id).to eq user.id
        expect(portfolio_all_fields.organization_id).to eq organization.id
        expect(portfolio_all_fields.name).to eq 'アプリ名更新'
        expect(portfolio_all_fields.url).to eq 'http://example.com/update'
        expect(portfolio_all_fields.introduction).to eq ''
        expect(portfolio_all_fields.github_repository.owner).to eq organization.github_username # GitHub URLは変更不可
        expect(portfolio_all_fields.github_repository.repo).to eq 'repo'
      end
      it '全項目をパラメータで渡した場合、ポートフォリオを作成し、201を返す' do
        patch auth_portfolio_path(portfolio_required_fields), headers:,
          params: { portfolio: { name: 'アプリ名更新', url: 'http://example.com/update', introduction: '紹介文', github_url: "https://example.github.com/#{organization.github_username}/repo" } }

        expect(response).to have_http_status :created

        portfolio_required_fields.reload
        expect(portfolio_required_fields.user_id).to eq user.id
        expect(portfolio_required_fields.organization_id).to eq organization.id
        expect(portfolio_required_fields.name).to eq 'アプリ名更新'
        expect(portfolio_required_fields.url).to eq 'http://example.com/update'
        expect(portfolio_required_fields.introduction).to eq '紹介文'
        expect(portfolio_required_fields.github_repository.owner).to eq organization.github_username # GitHub URLが未登録の場合は保存できる
        expect(portfolio_required_fields.github_repository.repo).to eq 'repo'
      end
    end

    describe '異常系' do
      let(:portfolio_not_editable) { FactoryBot.create(:portfolio, name: 'アプリ名') }
      let(:portfolio_with_github) { FactoryBot.create(:portfolio, user:, github_url: "https://example.github.com/#{user.github_username}/repo") }
      let(:portfolio_without_github) { FactoryBot.create(:portfolio, user:) }
      it '編集権限がない場合、401を返す' do
        patch auth_portfolio_path(portfolio_not_editable), headers:, params: { portfolio: { name: 'アプリ名更新' } }
        expect(response).to have_http_status :unauthorized

        portfolio_not_editable.reload
        expect(portfolio_not_editable.name).to eq 'アプリ名'
      end
      it 'GitHubのURLを変更しようとした場合、422を返す' do
        patch auth_portfolio_path(portfolio_with_github), headers:, params: { portfolio: { github_url: 'https://example.github.com/team/repo' } }

        expect(response).to have_http_status :unprocessable_entity
        json = response.parsed_body
        expect(json['error']).to eq ['GitHub URLは一度登録したら変更できません。']

        portfolio_with_github.reload
        expect(portfolio_with_github.github_url).to eq "#{ENV.fetch('GITHUB_DOMAIN', nil)}/#{user.github_username}/repo"
      end
      it 'GitHubのURLを初めて入力し、repositoryのownerでもcollaboratorでもない場合、422を返す' do
        allow_any_instance_of(Octokit::Client).to receive(:collaborator?).and_return(false)

        patch auth_portfolio_path(portfolio_without_github), headers:, params: { portfolio: { github_url: 'https://example.github.com/team/repo' } }

        expect(response).to have_http_status :unprocessable_entity
        json = response.parsed_body
        expect(json['message']).to eq 'GitHubのリポジトリが存在しないか、コラボレーターではありません'

        portfolio_without_github.reload
        expect(portfolio_without_github.github_url).to be nil
      end
    end
  end

  describe 'DELETE /auth/portfolios' do
    before do
      mock_auth(token:, auth0_id: user.auth0_id)
      allow_any_instance_of(Octokit::Client).to receive(:repository?).and_return(true)
      allow_any_instance_of(Octokit::Client).to receive(:collaborator?).and_return(true)
      health_check_response = instance_double(Net::HTTPSuccess)
      allow(health_check_response).to receive(:is_a?).with(Net::HTTPSuccess).and_return(true)
      allow(Net::HTTP).to receive(:get_response).with(URI.parse(url)).and_return(health_check_response)
    end

    describe '正常系' do
      let(:portfolio_with_association) { FactoryBot.create(:portfolio, user:, organization:, github_url: "https://example.github.com/#{organization.github_username}/repo") }
      let(:portfolio_without_association) { FactoryBot.create(:portfolio, :required_fields, user:) }
      it 'アソシエーションが存在しない場合、ポートフォリオを削除する' do
        portfolio_without_association.save!
        expect(Organization.count).to eq 0
        expect(Portfolio.count).to eq 1
        expect(GithubRepository.count).to eq 0

        delete auth_portfolio_path(portfolio_without_association), headers:, params: {}
        expect(response).to have_http_status :created

        expect(Portfolio.count).to eq 0
      end
      it 'アソシエーションが存在する場合、アソシエーションを含めポートフォリオを削除する' do
        portfolio_with_association.save!
        expect(Organization.count).to eq 1
        expect(Portfolio.count).to eq 1
        expect(GithubRepository.count).to eq 1

        delete auth_portfolio_path(portfolio_with_association), headers:, params: {}

        expect(response).to have_http_status :created

        expect(Organization.count).to eq 1
        expect(Portfolio.count).to eq 0
        expect(GithubRepository.count).to eq 0
      end
    end
    describe '異常系' do
      let(:portfolio_not_editable) { FactoryBot.create(:portfolio, name: 'アプリ名') }
      it '編集権限がない場合、401を返す' do
        delete auth_portfolio_path(portfolio_not_editable), headers:, params: {}
        expect(response).to have_http_status :unauthorized

        portfolio_not_editable.reload
        expect(portfolio_not_editable.name).to eq 'アプリ名'
      end
    end
  end
end
