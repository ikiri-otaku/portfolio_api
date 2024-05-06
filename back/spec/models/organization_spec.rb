require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'バリデーション' do
    let(:organization) { FactoryBot.build(:organization) }

    describe '必須項目' do
      before do
        expect(organization.valid?).to be true
      end
      it 'name が空の場合エラーになること' do
        organization.name = nil
        expect(organization.valid?).to be false
        expect(organization.errors[:name]).to eq ["can't be blank"]
      end
    end

    describe 'サイズ' do
      it 'name が50桁を超える場合エラーになること' do
        organization.name = 'a' * 50
        expect(organization.valid?).to be true
        organization.name = 'a' * 51
        expect(organization.valid?).to be false
        expect(organization.errors[:name]).to eq ["is too long (maximum is 50 characters)"]
      end
      it 'github_username が50桁を超える場合エラーになること' do
        organization.github_username = 'a' * 50
        expect(organization.valid?).to be true
        organization.github_username = 'a' * 51
        expect(organization.valid?).to be false
        expect(organization.errors[:github_username]).to eq ["is too long (maximum is 50 characters)"]
      end
    end

    describe '重複' do
      let(:another_organization) { FactoryBot.build(:organization) }
      it 'github_username が重複する場合エラーになること' do
        organization.save
        expect(another_organization.valid?).to be true

        another_organization.github_username = organization.github_username
        expect(another_organization.valid?).to be false
        expect(another_organization.errors[:github_username]).to eq ["has already been taken"]
      end
    end
  end
end
