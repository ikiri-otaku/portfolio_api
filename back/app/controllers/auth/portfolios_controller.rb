class Auth::PortfoliosController < Auth::ApplicationController
  INVALID_GITHUB_URL = { message: 'GitHubのリポジトリが存在しないか、コラボレーターではありません' }.freeze

  def create
    portfolio = current_user.portfolios.new(portfolio_params)

    # GitHubリポジトリ所有チェック
    return render status: :unprocessable_entity, json: INVALID_GITHUB_URL unless portfolio.check_repo_owner?(current_user)

    # ヘルスチェック
    portfolio.health_check

    # 保存
    portfolio.save_associations!

    render status: :created
  end

  def update; end # TODO

  def destroy; end # TODO

  private

  def portfolio_params
    params.require(:portfolio).permit(
      :name,
      :url,
      :introduction,
      :github_url # TODO: GithubRepository
      # :tech_names TODO
    )
  end
end
