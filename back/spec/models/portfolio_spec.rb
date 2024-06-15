require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  describe 'バリデーション' do
  end

  describe 'アソシエーション' do
  end

  describe 'メソッド' do
    let(:organization) { FactoryBot.create(:organization, :with_user) }
    let(:user_with_org) { organization.users.first }
    let(:user_no_org) { FactoryBot.create(:user) }

    describe '#check_repo_owner?' do
      let(:portfolio) { FactoryBot.build(:portfolio) }
      it 'github_urlが空の場合、trueを返す' do
        portfolio.github_url = ''
        expect(portfolio.check_repo_owner?(user_no_org)).to be true
      end
      it 'github_urlが不正な場合、falseを返す' do
        portfolio.github_url = 'https://example.github.com/'
        expect(portfolio.check_repo_owner?(user_no_org)).to be false
      end
      it '自身のリポジトリに存在しない場合、falseを返す' do
        allow_any_instance_of(Octokit::Client).to receive(:repository?).and_return(false)
        portfolio.github_url = "https://example.github.com/#{user_no_org.github_username}/repo"
        expect(portfolio.check_repo_owner?(user_no_org)).to be false
      end
      it '自身のリポジトリに存在する場合、trueを返す' do
        allow_any_instance_of(Octokit::Client).to receive(:repository?).and_return(true)
        portfolio.github_url = "https://example.github.com/#{user_no_org.github_username}/repo"
        expect(portfolio.check_repo_owner?(user_no_org)).to be true
      end
      it '自身がownerでない存在しないリポジトリの場合、例外を投げる' do
        allow_any_instance_of(Octokit::Client).to receive(:collaborator?).and_raise(Octokit::NotFound)
        portfolio.github_url = "https://example.github.com/#{organization.github_username}/repo"
        expect(portfolio.check_repo_owner?(user_no_org)).to be false
      end
      it 'チームのコラボレーターでない場合、falseを返す' do
        allow_any_instance_of(Octokit::Client).to receive(:collaborator?).and_return(false)
        portfolio.github_url = "https://example.github.com/#{organization.github_username}/repo"
        expect(portfolio.check_repo_owner?(user_no_org)).to be false
      end
      it 'チームのコラボレーターである場合、trueを返す' do
        allow_any_instance_of(Octokit::Client).to receive(:collaborator?).and_return(true)
        portfolio.github_url = "https://example.github.com/#{organization.github_username}/repo"
        expect(portfolio.check_repo_owner?(user_with_org)).to be true
      end
    end

    describe '#health_check' do
      let(:portfolio) { FactoryBot.build(:portfolio) }
      it 'ヘルスチェックに成功した場合、unhealthy_cntが0になる' do
        response = instance_double(Net::HTTPSuccess)
        allow(response).to receive(:is_a?).with(Net::HTTPSuccess).and_return(true)
        allow(Net::HTTP).to receive(:get_response).and_return(response)

        portfolio.unhealthy_cnt = 1
        portfolio.health_check
        expect(portfolio.unhealthy_cnt).to eq 0
      end
      it 'ヘルスチェックに失敗した場合、unhealthy_cntがインクリメントされる' do
        response = double('Net::HTTPInternalServerError')
        allow(Net::HTTP).to receive(:get_response).and_return(response)

        portfolio.unhealthy_cnt = 1
        portfolio.health_check
        expect(portfolio.unhealthy_cnt).to eq 2
      end
      it 'ヘルスチェックで例外が発生した場合、unhealthy_cntがインクリメントされる' do
        allow(Net::HTTP).to receive(:get_response).and_raise(StandardError.new('Request failed'))
        allow(Rails.logger).to receive(:info)

        portfolio.unhealthy_cnt = 1
        portfolio.health_check
        expect(portfolio.unhealthy_cnt).to eq 2
        expect(Rails.logger).to have_received(:info).with(/HealthCheckClientFailed/)
      end
    end

    describe '#save_associations!' do
      let(:portfolio_unsave) { FactoryBot.build(:portfolio) }
      let(:portfolio_saved) { FactoryBot.create(:portfolio) }

      describe '正常系' do
        it 'ユーザのリポジトリの場合、チームは作成せず、ポートフォリオを新規登録する' do
          portfolio_unsave.user = user_no_org
          portfolio_unsave.github_url = "https://example.github.com/#{user_no_org.github_username}/repo"
          expect(user_no_org.organizations.count).to eq 0

          portfolio_unsave.save_associations!

          portfolio_unsave.reload
          expect(portfolio_unsave.id).not_to be nil
          expect(portfolio_unsave.user_id).to eq user_no_org.id
          expect(portfolio_unsave.organization_id).to be nil

          user_no_org.reload
          expect(user_no_org.organizations.count).to eq 0
        end
        it 'すでに存在するチームのリポジトリの場合、チームに紐づいたポートフォリオを新規登録する' do
          portfolio_unsave.user = user_with_org
          portfolio_unsave.github_url = "https://example.github.com/#{organization.github_username}/repo"
          expect(user_with_org.organizations.count).to eq 1

          portfolio_unsave.save_associations!

          portfolio_unsave.reload
          expect(portfolio_unsave.id).not_to be nil
          expect(portfolio_unsave.user_id).to eq user_with_org.id
          expect(portfolio_unsave.organization_id).to eq organization.id

          user_with_org.reload
          expect(user_with_org.organizations.count).to eq 1
        end
        it '未登録のチームのリポジトリの場合、チームとポートフォリオを新規登録する' do
          portfolio_unsave.user = user_no_org
          portfolio_unsave.github_url = "https://example.github.com/organization_new/repo"
          expect(user_no_org.organizations.count).to eq 0

          portfolio_unsave.save_associations!
          organization_new = Organization.find_by(github_username: 'organization_new')

          portfolio_unsave.reload
          expect(portfolio_unsave.id).not_to be nil
          expect(portfolio_unsave.user_id).to eq user_no_org.id
          expect(portfolio_unsave.organization_id).to eq organization_new.id

          user_no_org.reload
          expect(user_no_org.organizations.count).to eq 1
          expect(user_no_org.organizations.first.id).to eq organization_new.id
        end
        it 'GitHubのURLが登録されていない場合、ポートフォリオのみ新規登録する' do
          portfolio_unsave.user = user_no_org
          portfolio_unsave.github_url = nil
          expect(user_no_org.organizations.count).to eq 0

          portfolio_unsave.save_associations!

          portfolio_unsave.reload
          expect(portfolio_unsave.id).not_to be nil
          expect(portfolio_unsave.user_id).to eq user_no_org.id
          expect(portfolio_unsave.organization_id).to be nil

          user_no_org.reload
          expect(user_no_org.organizations.count).to eq 0
        end
        it 'ポートフォリオを更新する' do
          portfolio_saved.introduction = '説明文を変更する'
          portfolio_saved.save_associations!
          expect(portfolio_saved.introduction).to eq '説明文を変更する'
        end
      end

      describe '異常系' do
        it 'ポートフォリオの登録に失敗した場合、チームとポートフォリオは作成されない' do
          allow_any_instance_of(Portfolio).to receive(:save!).and_raise(ActiveRecord::RecordInvalid)

          portfolio_unsave.user = user_no_org
          portfolio_unsave.github_url = "https://example.github.com/organization_new/repo"
          expect(Organization.count).to eq 0
          expect(Portfolio.count).to eq 0
          begin
            portfolio_unsave.save_associations!
          rescue ActiveRecord::RecordInvalid
          end

          expect(Organization.count).to eq 0
          expect(Portfolio.count).to eq 0
        end
      end
    end
  end
end
