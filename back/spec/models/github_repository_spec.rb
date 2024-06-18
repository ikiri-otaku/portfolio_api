require 'rails_helper'

RSpec.describe GithubRepository, type: :model do
  describe 'バリデーション' do
    let(:github_repository) { FactoryBot.build(:github_repository) }

    describe '必須項目' do
      before do
        expect(github_repository.valid?).to be true
      end
      it 'portfolio が空の場合エラーになること' do
        github_repository.portfolio = nil
        expect(github_repository.valid?).to be false
        expect(github_repository.errors.full_messages).to eq ['アプリを入力してください']
      end
      it 'owner が空の場合エラーになること' do
        github_repository.owner = nil
        expect(github_repository.valid?).to be false
        expect(github_repository.errors.full_messages).to eq ['所有者を入力してください']
      end
      it 'repo が空の場合エラーになること' do
        github_repository.repo = nil
        expect(github_repository.valid?).to be false
        expect(github_repository.errors.full_messages).to eq ['リポジトリ名を入力してください']
      end
    end

    describe 'サイズ' do
      it 'owner が50桁を超える場合エラーになること' do
        github_repository.owner = 'a' * 50
        expect(github_repository.valid?).to be true
        github_repository.owner = 'a' * 51
        expect(github_repository.valid?).to be false
        expect(github_repository.errors.full_messages).to eq ['所有者は50文字以内で入力してください']
      end
      it 'repo が100桁を超える場合エラーになること' do
        github_repository.repo = 'a' * 100
        expect(github_repository.valid?).to be true
        github_repository.repo = 'a' * 101
        expect(github_repository.valid?).to be false
        expect(github_repository.errors.full_messages).to eq ['リポジトリ名は100文字以内で入力してください']
      end
    end

    describe '重複' do
      let(:another_github_repository) { FactoryBot.build(:github_repository) }
      it 'github_username が重複する場合エラーになること' do
        github_repository.save
        expect(another_github_repository.valid?).to be true

        another_github_repository.portfolio = github_repository.portfolio
        expect(another_github_repository.valid?).to be false
        expect(another_github_repository.errors.full_messages).to eq ['アプリIDはすでに存在します']
      end
    end
  end

  describe 'メソッド' do
    let(:organization) { FactoryBot.create(:organization, :with_user) }
    let(:user_with_org) { organization.users.first }
    let(:user_no_org) { FactoryBot.create(:user) }

    describe '#check_repo_owner?' do
      let(:portfolio) { FactoryBot.build(:portfolio) }
      it '自身のリポジトリに存在しない場合、falseを返す' do
        allow_any_instance_of(Octokit::Client).to receive(:repository?).and_return(false)
        portfolio.github_url = "https://example.github.com/#{user_no_org.github_username}/repo"
        expect(portfolio.github_repository.check_repo_owner?(user_no_org)).to be false
      end
      it '自身のリポジトリに存在する場合、trueを返す' do
        allow_any_instance_of(Octokit::Client).to receive(:repository?).and_return(true)
        portfolio.github_url = "https://example.github.com/#{user_no_org.github_username}/repo"
        expect(portfolio.github_repository.check_repo_owner?(user_no_org)).to be true
      end
      it '自身がownerでない存在しないリポジトリの場合、例外を投げる' do
        allow_any_instance_of(Octokit::Client).to receive(:collaborator?).and_raise(Octokit::NotFound)
        portfolio.github_url = "https://example.github.com/#{organization.github_username}/repo"
        expect(portfolio.github_repository.check_repo_owner?(user_no_org)).to be false
      end
      it 'チームのコラボレーターでない場合、falseを返す' do
        allow_any_instance_of(Octokit::Client).to receive(:collaborator?).and_return(false)
        portfolio.github_url = "https://example.github.com/#{organization.github_username}/repo"
        expect(portfolio.github_repository.check_repo_owner?(user_no_org)).to be false
      end
      it 'チームのコラボレーターである場合、trueを返す' do
        allow_any_instance_of(Octokit::Client).to receive(:collaborator?).and_return(true)
        portfolio.github_url = "https://example.github.com/#{organization.github_username}/repo"
        expect(portfolio.github_repository.check_repo_owner?(user_with_org)).to be true
      end
    end
  end
end
