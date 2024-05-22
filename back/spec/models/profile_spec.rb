require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'バリデーション' do
    let(:profile) { FactoryBot.build(:profile) }

    describe 'サイズ' do
      it 'x_username が50桁を超える場合エラーになること' do
        profile.x_username = 'a' * 50
        expect(profile.valid?).to be true
        profile.x_username = 'a' * 51
        expect(profile.valid?).to be false
        expect(profile.errors[:x_username]).to eq ["is too long (maximum is 50 characters)"]
      end
      it 'atcoder_username が50桁を超える場合エラーになること' do
        profile.atcoder_username = 'a' * 50
        expect(profile.valid?).to be true
        profile.atcoder_username = 'a' * 51
        expect(profile.valid?).to be false
        expect(profile.errors[:atcoder_username]).to eq ["is too long (maximum is 50 characters)"]
      end
    end

    describe 'フォーマット' do
      it 'zenn_url が正しくないフォーマットの場合エラーになること' do
        profile.zenn_url = 'https://zenn.dev/username'
        expect(profile.valid?).to be true
        profile.zenn_url = 'invalid_url'
        expect(profile.valid?).to be false
        expect(profile.errors[:zenn_url]).to eq ["is invalid"]
      end
      it 'qiita_url が正しくないフォーマットの場合エラーになること' do
        profile.qiita_url = 'https://qiita.com/username'
        expect(profile.valid?).to be true
        profile.qiita_url = 'invalid_url'
        expect(profile.valid?).to be false
        expect(profile.errors[:qiita_url]).to eq ["is invalid"]
      end
    end

    describe '重複' do
      let(:another_profile) { FactoryBot.build(:profile) }
      it 'user_id が重複する場合エラーになること' do
        profile.save
        expect(another_profile.valid?).to be true
        another_profile.user_id = profile.user_id
        expect(another_profile.valid?).to be false
        expect(another_profile.errors[:user_id]).to eq ["has already been taken"]
      end
      it 'x_username が重複する場合エラーになること' do
        profile.save
        expect(another_profile.valid?).to be true
        another_profile.x_username = profile.x_username
        expect(another_profile.valid?).to be false
        expect(another_profile.errors[:x_username]).to eq ["has already been taken"]
      end
      it 'zenn_url が重複する場合エラーになること' do
        profile.save
        expect(another_profile.valid?).to be true
        another_profile.zenn_url = profile.zenn_url
        expect(another_profile.valid?).to be false
        expect(another_profile.errors[:zenn_url]).to eq ["has already been taken"]
      end
      it 'qiita_url が重複する場合エラーになること' do
        profile.save
        expect(another_profile.valid?).to be true
        another_profile.qiita_url = profile.qiita_url
        expect(another_profile.valid?).to be false
        expect(another_profile.errors[:qiita_url]).to eq ["has already been taken"]
      end
      it 'atcoder_username が重複する場合エラーになること' do
        profile.save
        expect(another_profile.valid?).to be true
        another_profile.atcoder_username = profile.atcoder_username
        expect(another_profile.valid?).to be false
        expect(another_profile.errors[:atcoder_username]).to eq ["has already been taken"]
      end
    end
  end
end
