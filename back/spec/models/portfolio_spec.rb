require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  describe 'バリデーション' do
    let(:portfolio) { FactoryBot.build(:portfolio) }

    describe '必須項目' do
      it 'name が空の場合エラーになること' do
        portfolio.name = nil
        expect(portfolio.valid?).to be false
        expect(portfolio.errors[:name]).to include("can't be blank")
      end

      it 'url が空の場合エラーになること' do
        portfolio.url = nil
        expect(portfolio.valid?).to be false
        expect(portfolio.errors[:url]).to include("can't be blank")
      end
    end

    describe 'サイズ' do
      it 'name が50桁を超える場合エラーになること' do
        portfolio.name = 'a' * 50
        expect(portfolio.valid?).to be true
        portfolio.name = 'a' * 51
        expect(portfolio.valid?).to be false
        expect(portfolio.errors[:name]).to include('is too long (maximum is 50 characters)')
      end

      it 'url が255桁を超える場合エラーになること' do
        portfolio.url = "http://#{'a' * 248}"
        expect(portfolio.valid?).to be true
        portfolio.url = "http://#{'a' * 249}"
        expect(portfolio.valid?).to be false
        expect(portfolio.errors[:url]).to include('is too long (maximum is 255 characters)')
      end

      it 'unhealthy_cnt が4を超える場合エラーになること' do
        portfolio.unhealthy_cnt = 4
        expect(portfolio.valid?).to be true
        portfolio.unhealthy_cnt = 5
        expect(portfolio.valid?).to be false
        expect(portfolio.errors[:unhealthy_cnt]).to include('must be less than or equal to 4')
      end
    end

    describe '数値' do
      it 'unhealthy_cnt が整数でない場合エラーになること' do
        portfolio.unhealthy_cnt = 3
        expect(portfolio.valid?).to be true
        portfolio.unhealthy_cnt = 'three'
        expect(portfolio.valid?).to be false
        expect(portfolio.errors[:unhealthy_cnt]).to include('is not a number')
      end

      it 'unhealthy_cnt が0未満の場合エラーになること' do
        portfolio.unhealthy_cnt = -1
        expect(portfolio.valid?).to be false
        expect(portfolio.errors[:unhealthy_cnt]).to include('must be greater than or equal to 0')
      end
    end

    describe '重複' do
      let(:another_portfolio) { FactoryBot.build(:portfolio) }
      it 'portfolio.url が重複する場合エラーになること' do
        portfolio.save
        expect(another_portfolio.valid?).to be true
        another_portfolio.url = portfolio.url
        expect(another_portfolio.valid?).to be false
        expect(another_portfolio.errors[:url]).to eq ['has already been taken']
      end
    end
  end

  describe 'アソシエーション' do
    it 'userに属していること' do
      portfolio = FactoryBot.create(:portfolio)
      expect(portfolio.user).to be_present
    end

    it 'organizationが任意であること' do
      portfolio_without_org = FactoryBot.create(:portfolio)
      portfolio_with_org = FactoryBot.create(:portfolio, :with_organization)
      expect(portfolio_without_org.organization).to be_nil
      expect(portfolio_with_org.organization).to be_present
    end

    xit 'organizationが存在する場合、portfolioを削除できないこと' do
      portfolio = FactoryBot.create(:portfolio, :with_organization)
      expect { portfolio.destroy }.to_not(change { Portfolio.count })
    end

    it 'organizationが存在しない場合、削除が成功すること' do
      portfolio = FactoryBot.create(:portfolio)
      expect(portfolio.destroy).to be_truthy
    end

    describe 'github_repository' do
      let!(:github_repository) { FactoryBot.create(:github_repository) }
      it 'portfolio を削除すると github_repository を同時に削除すること' do
        expect { github_repository.portfolio.destroy! }.to change { GithubRepository.count }.by(-1)
      end
    end
  end

  describe 'メソッド' do
    let(:organization) { FactoryBot.create(:organization, :with_user) }
    let(:user_with_org) { organization.users.first }
    let(:user_no_org) { FactoryBot.create(:user) }

    describe '#github_url' do
      let(:portfolio) { FactoryBot.build(:portfolio) }
      it 'github_repository が紐づかない場合、nilを返す' do
        expect(portfolio.github_url).to be nil
      end
      it 'github_repository が紐づく場合、URLを返す' do
        portfolio.build_github_repository(owner: 'owner', repo: 'repo')
        expect(portfolio.github_url).to eq "#{ENV.fetch('GITHUB_DOMAIN', nil)}/owner/repo"
      end
    end

    describe '#github_url=' do
      let(:portfolio) { FactoryBot.build(:portfolio) }
      it 'github_urlが不正な場合、例外をスローする' do
        expect do
          portfolio.github_url = 'https://example.github.com/'
        end.to raise_error(ActiveRecord::RecordInvalid, /バリデーションに失敗しました: GitHub URLはリポジトリのトップページを指定してください/)
        expect do
          portfolio.github_url = 'https://example.github.com/owner/repo/1'
        end.to raise_error(ActiveRecord::RecordInvalid, /バリデーションに失敗しました: GitHub URLはリポジトリのトップページを指定してください/)
      end
      it 'github_urlが正常な場合、github_repositoryを紐づける' do
        portfolio.github_url = 'https://example.github.com/owner/repo?id=100'
        expect(portfolio.github_repository.owner).to eq 'owner'
        expect(portfolio.github_repository.repo).to eq 'repo'
        expect(portfolio.github_url).to eq "#{ENV.fetch('GITHUB_DOMAIN', nil)}/owner/repo"
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
          portfolio_unsave.github_url = 'https://example.github.com/organization_new/repo'
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
          portfolio_unsave.github_url = 'https://example.github.com/organization_new/repo'
          expect(Organization.count).to eq 0
          expect(Portfolio.count).to eq 0
          begin
            portfolio_unsave.save_associations!
          rescue ActiveRecord::RecordInvalid
            nil
          end

          expect(Organization.count).to eq 0
          expect(Portfolio.count).to eq 0
        end
      end
    end
  end
end
