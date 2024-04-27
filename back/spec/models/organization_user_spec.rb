require 'rails_helper'

RSpec.describe OrganizationUser, type: :model do
  let(:organization) { FactoryBot.create(:organization) }
  let(:organization_user) { organization.organization_users.first }

  describe '必須項目' do
    before do
      expect(organization_user.valid?).to be true
    end
    it 'organization_id が空の場合エラーになること' do
      organization_user.organization_id = nil
      expect(organization_user.valid?).to be false
      expect(organization_user.errors[:organization]).to include("must exist")
    end
    it 'user_id が空の場合エラーになること' do
      organization_user.user_id = nil
      expect(organization_user.valid?).to be false
      expect(organization_user.errors[:user]).to include("must exist")
    end
  end

  describe '重複' do
    it 'organizationとuser の組み合わせが重複する場合エラーになること' do
      another_organization_user = FactoryBot.build(:organization_user, organization: organization_user.organization, user: organization_user.user)
      expect(another_organization_user.valid?).to be false
      expect(another_organization_user.errors[:user_id]).to eq ["has already been taken"]
    end
  end
end
