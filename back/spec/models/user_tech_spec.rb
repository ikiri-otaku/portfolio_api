require 'rails_helper'

RSpec.describe UserTech, type: :model do
  describe 'バリデーション' do
    let(:user) { FactoryBot.create(:user) }
    let(:tech) { FactoryBot.create(:tech) }

    describe '必須項目' do
      it 'user が空の場合エラーになること' do
        user_tech = UserTech.new(tech:)
        expect(user_tech.valid?).to be false
        expect(user_tech.errors.size).to eq 1
        expect(user_tech.errors[:user]).to eq ['を入力してください']
      end
      it 'tech が空の場合エラーになること' do
        user_tech = UserTech.new(user:)
        expect(user_tech.valid?).to be false
        expect(user_tech.errors.size).to eq 1
        expect(user_tech.errors[:tech]).to eq ['を入力してください']
      end
    end

    describe '重複' do
      it 'userとtech の組み合わせが重複する場合エラーになること' do
        user.teches << tech

        another_user_tech = UserTech.new(user:, tech:)
        expect(another_user_tech.valid?).to be false
        expect(another_user_tech.errors.size).to eq 1
        expect(another_user_tech.errors[:user_id]).to eq ['はすでに存在します']
      end
    end

    describe '範囲' do
      it 'exp_months_job の値が0以上でない場合エラーになること' do
        user_tech = UserTech.new(user:, tech:, exp_months_job: 0)
        expect(user_tech.valid?).to be true

        user_tech.exp_months_job = -1
        expect(user_tech.valid?).to be false
        expect(user_tech.errors.size).to eq 1
        expect(user_tech.errors[:exp_months_job]).to eq ['は0..99の範囲に含めてください']
      end
      it 'exp_months_job の値が99以下でない場合エラーになること' do
        user_tech = UserTech.new(user:, tech:, exp_months_job: 99)
        expect(user_tech.valid?).to be true

        user_tech.exp_months_job = 100
        expect(user_tech.valid?).to be false
        expect(user_tech.errors.size).to eq 1
        expect(user_tech.errors[:exp_months_job]).to eq ['は0..99の範囲に含めてください']
      end

      it 'exp_months_hobby の値が0以上でない場合エラーになること' do
        user_tech = UserTech.new(user:, tech:, exp_months_hobby: 0)
        expect(user_tech.valid?).to be true

        user_tech.exp_months_hobby = -1
        expect(user_tech.valid?).to be false
        expect(user_tech.errors.size).to eq 1
        expect(user_tech.errors[:exp_months_hobby]).to eq ['は0..99の範囲に含めてください']
      end
      it 'exp_months_hobby の値が99以下でない場合エラーになること' do
        user_tech = UserTech.new(user:, tech:, exp_months_hobby: 99)
        expect(user_tech.valid?).to be true

        user_tech.exp_months_hobby = 100
        expect(user_tech.valid?).to be false
        expect(user_tech.errors.size).to eq 1
        expect(user_tech.errors[:exp_months_hobby]).to eq ['は0..99の範囲に含めてください']
      end
    end
  end

  describe '削除' do
    let(:user) { FactoryBot.create(:user, :with_tech) }
    it 'user を削除した場合、削除されること' do
      tech = user.teches.first

      user.destroy!
      expect(User.count).to eq 0
      expect(UserTech.count).to eq 0
      expect(Tech.where(id: tech.id).count).to eq 1
    end
    it 'tech を削除した場合、削除されること' do
      tech = user.teches.first

      tech.destroy!
      expect(User.where(id: user.id).count).to eq 1
      expect(UserTech.count).to eq 0
      expect(Tech.count).to eq 0
    end
  end
end
