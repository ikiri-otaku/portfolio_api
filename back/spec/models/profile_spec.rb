require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'バリデーション' do
    let(:profile) { FactoryBot.build(:profile) }

    describe 'サイズ' do
      it 'location が255桁を超える場合エラーになること' do
        profile.location = 'a' * 255
        expect(profile.valid?).to be true
        profile.location = 'a' * 256
        expect(profile.valid?).to be false
        expect(profile.errors[:location]).to eq ['is too long (maximum is 255 characters)']
      end
      it 'company が255桁を超える場合エラーになること' do
        profile.company = 'a' * 255
        expect(profile.valid?).to be true
        profile.company = 'a' * 256
        expect(profile.valid?).to be false
        expect(profile.errors[:company]).to eq ['is too long (maximum is 255 characters)']
      end
      it 'work_location が255桁を超える場合エラーになること' do
        profile.work_location = 'a' * 255
        expect(profile.valid?).to be true
        profile.work_location = 'a' * 256
        expect(profile.valid?).to be false
        expect(profile.errors[:work_location]).to eq ['is too long (maximum is 255 characters)']
      end
      it 'x_username が50桁を超える場合エラーになること' do
        profile.x_username = 'a' * 50
        expect(profile.valid?).to be true
        profile.x_username = 'a' * 51
        expect(profile.valid?).to be false
        expect(profile.errors[:x_username]).to eq ['is too long (maximum is 50 characters)']
      end
      it 'zenn_username が50桁を超える場合エラーになること' do
        profile.zenn_username = 'a' * 50
        expect(profile.valid?).to be true
        profile.zenn_username = 'a' * 51
        expect(profile.valid?).to be false
        expect(profile.errors[:zenn_username]).to eq ['is too long (maximum is 50 characters)']
      end
      it 'qiita_username が50桁を超える場合エラーになること' do
        profile.qiita_username = 'a' * 50
        expect(profile.valid?).to be true
        profile.qiita_username = 'a' * 51
        expect(profile.valid?).to be false
        expect(profile.errors[:qiita_username]).to eq ['is too long (maximum is 50 characters)']
      end
      it 'atcoder_username が50桁を超える場合エラーになること' do
        profile.atcoder_username = 'a' * 50
        expect(profile.valid?).to be true
        profile.atcoder_username = 'a' * 51
        expect(profile.valid?).to be false
        expect(profile.errors[:atcoder_username]).to eq ['is too long (maximum is 50 characters)']
      end
    end

    describe '重複' do
      let(:another_profile) { FactoryBot.build(:profile) }
      before do
        profile.save
        expect(profile.valid?).to be true
      end
      it 'user_id が重複する場合エラーになること' do
        another_profile.user_id = profile.user_id
        expect(another_profile.valid?).to be false
        expect(another_profile.errors[:user_id]).to eq ['has already been taken']
      end
      it 'x_username が重複する場合エラーになること' do
        another_profile.x_username = profile.x_username
        expect(another_profile.valid?).to be false
        expect(another_profile.errors[:x_username]).to eq ['has already been taken']
      end
      it 'zenn_username が重複する場合エラーになること' do
        another_profile.zenn_username = profile.zenn_username
        expect(another_profile.valid?).to be false
        expect(another_profile.errors[:zenn_username]).to eq ['has already been taken']
      end
      it 'qiita_username が重複する場合エラーになること' do
        another_profile.qiita_username = profile.qiita_username
        expect(another_profile.valid?).to be false
        expect(another_profile.errors[:qiita_username]).to eq ['has already been taken']
      end
      it 'atcoder_username が重複する場合エラーになること' do
        another_profile.atcoder_username = profile.atcoder_username
        expect(another_profile.valid?).to be false
        expect(another_profile.errors[:atcoder_username]).to eq ['has already been taken']
      end
    end
  end
end
