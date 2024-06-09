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

    it 'organizationが存在する場合、portfolioを削除できないこと' do
      portfolio = FactoryBot.create(:portfolio, :with_organization)
      expect { portfolio.destroy }.to_not(change { Portfolio.count })
    end

    it 'organizationが存在しない場合、削除が成功すること' do
      portfolio = FactoryBot.create(:portfolio)
      expect(portfolio.destroy).to be_truthy
    end
  end
end
