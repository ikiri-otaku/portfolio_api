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
end
