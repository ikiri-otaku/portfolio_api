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
    let!(:portfolio) { FactoryBot.create(:portfolio, user:, organization:) }

    it 'userの削除時にportfolioをnulに設定' do
      user.destroy
      expect(portfolio.reload.user).to be_nil
    end

    it 'organizationの削除時にportfolioをnulに設定' do
      organization.destroy
      expect(portfolio.reload.organization).to be_nil
    end
  end
end
