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
        expect(user.errors[:name]).to eq ["can't be blank"]
      end
    end

    describe 'サイズ' do
      it 'name が50桁を超える場合エラーになること' do
        user.name = 'a' * 50
        expect(user.valid?).to be true
        user.name = 'a' * 51
        expect(user.valid?).to be false
        expect(user.errors[:name]).to eq ["is too long (maximum is 50 characters)"]
      end
      it 'github_username が50桁を超える場合エラーになること' do
        user.github_username = 'a' * 50
        expect(user.valid?).to be true
        user.github_username = 'a' * 51
        expect(user.valid?).to be false
        expect(user.errors[:github_username]).to eq ["is too long (maximum is 50 characters)"]
      end
    end

    describe '重複' do
      let(:another_user) { FactoryBot.build(:user) }
      it 'github_username が重複する場合エラーになること' do
        user.save
        expect(another_user.valid?).to be true

        another_user.github_username = user.github_username
        expect(another_user.valid?).to be false
        expect(another_user.errors[:github_username]).to eq ["has already been taken"]
      end
    end
  end
  
  describe 'アソシエーション' do
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

    it '1人のユーザーが削除されても、他にユーザーがいればorganizationは削除されないこと' do
      organization = FactoryBot.create(:organization)
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      user1.organizations << organization
      user2.organizations << organization

      user1.destroy

      expect(Organization.exists?(organization.id)).to be true
    end
  end
end
