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
        expect(portfolio.errors[:name]).to include("is too long (maximum is 50 characters)")
      end

      it 'url が255桁を超える場合エラーになること' do
        portfolio.url = 'a' * 255
        expect(portfolio.valid?).to be true
        portfolio.url = 'a' * 256
        expect(portfolio.valid?).to be false
        expect(portfolio.errors[:url]).to include("is too long (maximum is 255 characters)")
      end

      it 'unhealthy_cnt が4を超える場合エラーになること' do
        portfolio.unhealthy_cnt = 4
        expect(portfolio.valid?).to be true
        portfolio.unhealthy_cnt = 5
        expect(portfolio.valid?).to be false
        expect(portfolio.errors[:unhealthy_cnt]).to include("must be less than or equal to 4")
      end
    end

    describe '数値' do
      it 'unhealthy_cnt が整数である場合有効であること' do
        portfolio.unhealthy_cnt = 3
        expect(portfolio.valid?).to be true
      end

      it 'unhealthy_cnt が整数でない場合エラーになること' do
        portfolio.unhealthy_cnt = 'three'
        expect(portfolio.valid?).to be false
        expect(portfolio.errors[:unhealthy_cnt]).to include("is not a number")
      end
    end  
  end
end