require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:bookmark) { FactoryBot.create(:bookmark) }

  describe '必須項目' do
    it 'portfolio_id が空の場合エラーになること' do
      bookmark.portfolio = nil
      expect(bookmark.valid?).to be false
      expect(bookmark.errors[:portfolio]).to include('を入力してください')
    end
    it 'user_id が空の場合エラーになること' do
      bookmark.user = nil
      expect(bookmark.valid?).to be false
      expect(bookmark.errors[:user]).to include('を入力してください')
    end
  end

  describe '重複' do
    let(:another_bookmark) { FactoryBot.create(:bookmark) }
    it 'portfolioとuserの組み合わせが重複する場合エラーになること' do
      bookmark.save
      expect(another_bookmark.valid?).to be true

      another_bookmark.portfolio = bookmark.portfolio
      another_bookmark.user = bookmark.user
      expect(another_bookmark.valid?).to be false
      expect(another_bookmark.errors[:portfolio_id]).to eq ['はすでに存在します']
    end
  end
end
