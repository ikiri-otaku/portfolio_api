require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  describe 'バリデーション' do
    let(:portfolio) { FactoryBot.build(:portfolio) }

    describe '必須項目' do
      it 'name が空の場合エラーになること' do
        portfolio.name = nil
        expect(portfolio.valid?).to be false
        expect(portfolio.errors[:name]).to include('を入力してください')
      end

      it 'url が空の場合エラーになること' do
        portfolio.url = nil
        expect(portfolio.valid?).to be false
        expect(portfolio.errors[:url]).to include('を入力してください', 'は不正な値です')
      end
    end

    describe 'サイズ' do
      it 'name が50桁を超える場合エラーになること' do
        portfolio.name = 'a' * 50
        expect(portfolio).to be_valid
        portfolio.name = 'a' * 51
        portfolio.valid?
        expect(portfolio.errors[:name]).to include('は50文字以内で入力してください')
      end

      it 'url が255桁を超える場合エラーになること' do
        portfolio.url = "http://#{'a' * 248}"
        expect(portfolio.valid?).to be true
        portfolio.url = "http://#{'a' * 249}"
        expect(portfolio.valid?).to be false
        expect(portfolio.errors[:url]).to include('は255文字以内で入力してください')
      end

      it 'unhealthy_cnt が4を超える場合エラーになること' do
        portfolio.unhealthy_cnt = 4
        expect(portfolio.valid?).to be true
        portfolio.unhealthy_cnt = 5
        expect(portfolio.valid?).to be false
        expect(portfolio.errors[:unhealthy_cnt]).to include('は4以下の値にしてください')
      end
    end

    describe '数値' do
      it 'unhealthy_cnt が整数でない場合エラーになること' do
        portfolio.unhealthy_cnt = 3
        expect(portfolio.valid?).to be true
        portfolio.unhealthy_cnt = 'three'
        expect(portfolio.valid?).to be false
        expect(portfolio.errors[:unhealthy_cnt]).to include('は数値で入力してください')
      end

      it 'unhealthy_cnt が0未満の場合エラーになること' do
        portfolio.unhealthy_cnt = -1
        expect(portfolio.valid?).to be false
        expect(portfolio.errors[:unhealthy_cnt]).to include('は0以上の値にしてください')
      end
    end

    describe '重複' do
      let(:another_portfolio) { FactoryBot.build(:portfolio) }

      it 'portfolio.url が重複する場合エラーになること' do
        portfolio.save
        expect(another_portfolio.valid?).to be true
        another_portfolio.url = portfolio.url
        expect(another_portfolio.valid?).to be false
        expect(another_portfolio.errors[:url]).to eq ['はすでに存在します']
      end
    end
  end

  describe 'アソシエーション' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:organization) { FactoryBot.create(:organization) }
    let!(:portfolio) { FactoryBot.create(:portfolio, :with_picture, user:, organization:) }

    it 'userの削除時にportfolioをnulに設定' do
      user.destroy
      expect(portfolio.reload.user).to be_nil
    end

    it 'organizationの削除時にportfolioをnulに設定' do
      organization.destroy
      expect(portfolio.reload.organization).to be_nil
    end

    it '削除すると、関連するデータも削除されること' do
      expect(Picture.where(imageable_type: 'Portfolio', imageable_id: portfolio.id).count).to eq 1

      portfolio.destroy!

      expect(Portfolio.where(id: portfolio.id).count).to eq 0
      expect(Picture.where(imageable_type: 'Portfolio', imageable_id: portfolio.id).count).to eq 0
    end

    describe 'github_repository' do
      let!(:github_repository) { FactoryBot.create(:github_repository) }
      it 'portfolio を削除すると github_repository を同時に削除すること' do
        expect { github_repository.portfolio.destroy! }.to change { GithubRepository.count }.by(-1)
      end
    end
  end

  describe 'メソッド' do
    # organization
    let(:organization) { FactoryBot.create(:organization, :with_user) }
    let(:user_with_org) { organization.users.first }
    # user
    let(:user_no_org) { FactoryBot.create(:user) }

    describe '.keyword_like' do
      # tech
      let!(:tech_ruby) { FactoryBot.create(:tech, name: 'Ruby') }
      let!(:tech_keyword) { FactoryBot.create(:tech, name: 'tech_keyword') }
      # portfolio
      let!(:portfolio_1) { FactoryBot.create(:portfolio, name: 'xkeywordx') }
      let!(:portfolio_2) { FactoryBot.create(:portfolio, introduction: 'xkeywordx') }
      let!(:portfolio_3) { FactoryBot.create(:portfolio) }

      before do
        portfolio_2.teches << tech_ruby
        portfolio_3.teches << tech_keyword
      end

      it 'keywordが指定されていない場合、全件取得できる' do
        expect(Portfolio.keyword_like('').pluck(:id)).to eq [portfolio_1.id, portfolio_2.id, portfolio_3.id]
      end

      it 'keywordが指定された場合、一致した結果が取得できる' do
        expect(Portfolio.keyword_like('KeyWord').pluck(:id)).to eq [portfolio_1.id, portfolio_2.id, portfolio_3.id]
        expect(Portfolio.keyword_like('ruby').pluck(:id)).to eq [portfolio_2.id]
      end
    end

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
