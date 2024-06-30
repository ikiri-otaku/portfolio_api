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
    it 'ユーザー削除時に関連するポートフォリオが削除されること' do
      user = FactoryBot.create(:user)
      portfolio = FactoryBot.create(:portfolio, user:)

      user.destroy

      expect(Portfolio.exists?(portfolio.id)).to be false
    end

    it 'ユーザーが削除されても関連するポートフォリオがorganizationに関連している場合、user_idがnilになること' do
      user = FactoryBot.create(:user)
      organization = FactoryBot.create(:organization)
      portfolio = FactoryBot.create(:portfolio, user:, organization:)

      user.destroy

      expect(portfolio.reload.user_id).to be_nil
      expect(Portfolio.exists?(portfolio.id)).to be true
    end

    it 'ユーザー削除時に関連するorganizationが削除されること' do
      user = FactoryBot.create(:user)
      organization = FactoryBot.create(:organization)
      user.organizations << organization

      user.destroy

      expect(Organization.exists?(organization.id)).to be false
    end

    it '1人のユーザーが削除されても、他にユーザーがいればorganizationは削除されないこと' do
      organization = FactoryBot.create(:organization)
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      user1.organizations << organization
      user2.organizations << organization

      user1.destroy

      expect(Organization.exists?(organization.id)).to be true
    end

    it '複数のユーザーがすべて削除された場合、関連するorganizationも削除されること' do
      organization = FactoryBot.create(:organization)
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      user1.organizations << organization
      user2.organizations << organization

      user1.destroy
      user2.destroy

      expect(Organization.exists?(organization.id)).to be false
    end
  end
end
