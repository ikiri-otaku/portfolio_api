require 'rails_helper'

RSpec.describe OrganizationUser, type: :model do
  let(:organization_user) { FactoryBot.create(:organization_user) }

  describe '必須項目' do
    before do
      expect(organization_user.valid?).to be true
    end
    it 'organization_id が空の場合エラーになること' do
      organization_user.organization_id = nil
      expect(organization_user.valid?).to be false
      expect(organization_user.errors[:organization]).to eq ["must exist", "can't be blank"]
    end
    it 'user_id が空の場合エラーになること' do
      organization_user.user_id = nil
      expect(organization_user.valid?).to be false
      expect(organization_user.errors[:user]).to eq ["must exist", "can't be blank"]
    end
  end
end
