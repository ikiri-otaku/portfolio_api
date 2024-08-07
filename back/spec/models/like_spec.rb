require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'バリデーション' do
    let(:user) { FactoryBot.create(:user) }
    let(:portfolio) { FactoryBot.create(:portfolio) }

    describe '必須項目' do
      it 'user が空の場合エラーになること' do
        like = Like.new(portfolio:)
        expect(like.valid?).to be false
        expect(like.errors.size).to eq 1
        expect(like.errors[:user]).to eq ['を入力してください']
      end
      it 'portfolio が空の場合エラーになること' do
        like = Like.new(user:)
        expect(like.valid?).to be false
        expect(like.errors.size).to eq 1
        expect(like.errors[:portfolio]).to eq ['を入力してください']
      end
    end

    describe '重複' do
      it 'userとportfolio の組み合わせが重複する場合エラーになること' do
        Like.create(user:, portfolio:)

        another_like = Like.new(user:, portfolio:)
        expect(another_like.valid?).to be false
        expect(another_like.errors.size).to eq 1
        expect(another_like.errors[:user_id]).to eq ['はすでに存在します']
      end
    end
  end

  describe 'アソシエーション' do
    describe '削除' do
      let!(:user) { FactoryBot.create(:user) }
      let!(:portfolio) { FactoryBot.create(:portfolio, user:) }

      before do
        user.likes.create!(portfolio:)
      end

      it 'user を削除した場合関連する likes が削除されること' do
        expect { user.destroy! }.to change { Like.count }.from(1).to(0)
        expect(User.count).to eq 0
        expect(Portfolio.where(id: portfolio.id).count).to eq 1
      end
      
      it 'portfolio を削除した場合関連する likes が削除されること' do
        expect { portfolio.destroy! }.to change { Like.count }.from(1).to(0)
        expect(User.where(id: user.id).count).to eq 1
        expect(Portfolio.count).to eq 0
      end
    end
  end
end
