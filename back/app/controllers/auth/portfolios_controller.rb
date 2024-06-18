class Auth::PortfoliosController < Auth::ApplicationController
  INVALID_GITHUB_URL = { message: 'GitHubのリポジトリが存在しないか、コラボレーターではありません' }.freeze

  def create
    portfolio = current_user.portfolios.new(portfolio_params)

    # GitHubリポジトリ所有チェック
    if portfolio.github_repository && !portfolio.github_repository&.check_repo_owner?(current_user)
      return render status: :unprocessable_entity, json: INVALID_GITHUB_URL
    end

    # ヘルスチェック
    portfolio.health_check

    # 保存
    portfolio.save_associations!

    render status: :created
  end

  # TODO
  def update; end

  # TODO
  def destroy; end

  private

  def portfolio_params
    params.require(:portfolio).permit(
      :name,
      :url,
      :introduction,
      :github_url
      # :tech_names TODO
    )
  end
end
