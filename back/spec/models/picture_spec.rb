require 'rails_helper'

RSpec.describe Picture, type: :model do
  describe 'バリデーション' do
    let(:profile) { FactoryBot.create(:profile, :with_picture) }
    let(:picture) { profile.pictures.first }

    describe 'サイズ' do
      it 'object_key が255桁を超える場合エラーになること' do
        picture.object_key = 'a' * 255
        expect(picture.valid?).to be true
        picture.object_key = 'a' * 256
        expect(picture.valid?).to be false
        expect(picture.errors[:object_key]).to eq ['は255文字以内で入力してください']
      end
    end
  end

  describe 'アソシエーション' do
    let(:profile) { FactoryBot.create(:profile, :with_picture) }
    let(:picture) { profile.pictures.first }

    it '適切な imageable が設定されること' do
      expect(picture.imageable_type).to eq 'Profile'
      expect(picture.imageable_id).to eq profile.id
    end
  end
end
