require 'rails_helper'

RSpec.describe PortfolioTech, type: :model do
  describe 'バリデーション' do
    let(:portfolio) { FactoryBot.create(:portfolio) }
    let(:tech) { FactoryBot.create(:tech) }

    describe '必須項目' do
      it 'portfolio が空の場合エラーになること' do
        portfolio_tech = PortfolioTech.new(tech:)
        expect(portfolio_tech.valid?).to be false
        expect(portfolio_tech.errors.size).to eq 1
        expect(portfolio_tech.errors[:portfolio]).to eq ['を入力してください']
      end

      it 'tech が空の場合エラーになること' do
        portfolio_tech = PortfolioTech.new(portfolio:)
        expect(portfolio_tech.valid?).to be false
        expect(portfolio_tech.errors.size).to eq 1
        expect(portfolio_tech.errors[:tech]).to eq ['を入力してください']
      end
    end

    describe '重複' do
      it 'portfolioとtech の組み合わせが重複する場合エラーになること' do
        portfolio.teches << tech

        another_portfolio_tech = PortfolioTech.new(portfolio:, tech:)
        expect(another_portfolio_tech.valid?).to be false
        expect(another_portfolio_tech.errors.size).to eq 1
        expect(another_portfolio_tech.errors[:portfolio_id]).to eq ['はすでに存在します']
      end
    end

    describe '削除' do
      let(:portfolio) { FactoryBot.create(:portfolio, :with_tech) }
      it 'portfolio を削除した場合、削除されること' do
        tech = portfolio.teches.first

        portfolio.destroy!
        expect(Portfolio.count).to eq 0
        expect(PortfolioTech.count).to eq 0
        expect(Tech.where(id: tech.id).count).to eq 1
      end

      it 'tech を削除した場合、削除されること' do
        tech = portfolio.teches.first

        tech.destroy!
        expect(Portfolio.where(id: portfolio.id).count).to eq 1
        expect(PortfolioTech.count).to eq 0
        expect(Tech.count).to eq 0
      end
    end
  end
end
