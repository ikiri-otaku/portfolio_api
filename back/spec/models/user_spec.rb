require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    let(:user) { FactoryBot.build(:user) }

    describe '必須項目' do
      before do
        expect(user.valid?).to be true
      end
      it 'name が空の場合エラーになること' do
        user.name = nil
        expect(user.valid?).to be false
        expect(user.errors[:name]).to eq ['を入力してください']
      end
    end

    describe 'サイズ' do
      it 'name が50桁を超える場合エラーになること' do
        user.name = 'a' * 50
        expect(user.valid?).to be true
        user.name = 'a' * 51
        expect(user.valid?).to be false
        expect(user.errors[:name]).to eq ['は50文字以内で入力してください']
      end
      it 'github_username が50桁を超える場合エラーになること' do
        user.github_username = 'a' * 50
        expect(user.valid?).to be true
        user.github_username = 'a' * 51
        expect(user.valid?).to be false
        expect(user.errors[:github_username]).to eq ['は50文字以内で入力してください']
      end
    end

    describe '重複' do
      let(:another_user) { FactoryBot.build(:user) }
      it 'github_username が重複する場合エラーになること' do
        user.save
        expect(another_user.valid?).to be true

        another_user.github_username = user.github_username
        expect(another_user.valid?).to be false
        expect(another_user.errors[:github_username]).to eq ['はすでに存在します']
      end
    end
  end

  describe 'アソシエーション' do
    let!(:organization) { FactoryBot.create(:organization) }
    let!(:user) { FactoryBot.create(:user) }
    let!(:portfolio) { FactoryBot.create(:portfolio, user:, organization:) }

    before do
      user.organizations << organization
      user.portfolios << portfolio
    end

    it 'organizationに関連付けられていること' do
      expect(user.organizations).to include(organization)
    end

    it 'userが複数のorganizationsに関連付けられること' do
      organization2 = FactoryBot.create(:organization)
      user.organizations << organization2
      expect(user.organizations).to include(organization, organization2)
    end

    it 'userが削除された場合organizationの関連付けが削除される' do
      user.destroy
      expect(OrganizationUser.where(user_id: user.id).count).to eq 0
      expect(Organization.where(id: organization.id).count).to eq 1
    end

    it 'userが削除された場合portfolioの関連付けが削除される' do
      user.destroy
      expect(Portfolio.where(user_id: user.id).count).to eq 0
      expect(Portfolio.where(id: portfolio.id).count).to eq 1
    end
  end
end
