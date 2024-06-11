require 'rails_helper'

RSpec.describe OrganizationUser, type: :model do
  let(:organization) { FactoryBot.create(:organization, :with_user) }

  describe '必須項目' do
    it 'organization_id が空の場合エラーになること' do
      organization_user = OrganizationUser.new(organization: nil, user: organization.users[0])
      expect(organization_user.valid?).to be false
      expect(organization_user.errors[:organization]).to include('must exist')
    end
    it 'user_id が空の場合エラーになること' do
      organization_user = OrganizationUser.new(organization:, user: nil)
      expect(organization_user.valid?).to be false
      expect(organization_user.errors[:user]).to include('must exist')
    end
  end

  describe '重複' do
    it 'organizationとuser の組み合わせが重複する場合エラーになること' do
      another_organization_user = OrganizationUser.new(organization:, user: organization.users[0])
      expect(another_organization_user.valid?).to be false
      expect(another_organization_user.errors[:user_id]).to eq ['has already been taken']
    end
  end
end
