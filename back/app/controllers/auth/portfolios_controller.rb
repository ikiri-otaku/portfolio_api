class Auth::PortfoliosController < Auth::ApplicationController
  INVALID_GITHUB_URL = { message: 'GitHubのリポジトリが存在しないか、コラボレーターではありません' }.freeze

  # GET    /auth/portfolios/:id
  def show
    @portfolio = Portfolio.eager_load(:user, :organization).find(params[:id])
    # TODO: View数更新
    # TODO: 技術、画像、LIKE、View取得
    render status: :ok, json: @portfolio.to_api_response.merge(editable: check_repo_owner?(show: true))
  end

  # POST   /auth/portfolios
  def create
    @portfolio = current_user.portfolios.new(portfolio_params)

    # GitHubリポジトリ所有チェック
    return render status: :unprocessable_entity, json: INVALID_GITHUB_URL unless check_repo_owner?

    # ヘルスチェック
    @portfolio.health_check

    # 保存
    @portfolio.save_associations!

    render status: :created
  end

  # PATCH  /auth/portfolios
  def update
    @portfolio = Portfolio.find(params[:id])
    @portfolio.attributes = portfolio_params

    # 更新権限チェック
    return render status: :unauthorized unless check_authority?

    # GitHubリポジトリ所有チェック
    return render status: :unprocessable_entity, json: INVALID_GITHUB_URL unless check_repo_owner?

    # 保存
    @portfolio.save_associations!

    render status: :created
  end

  # DELETE /auth/portfolios
  def destroy
    @portfolio = Portfolio.find(params[:id])

    # 削除権限チェック
    return render status: :unauthorized unless check_authority?

    # 削除
    @portfolio.destroy!

    render status: :created
  end

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

  def check_repo_owner?(show: false)
    return current_user.id == @portfolio.user_id unless @portfolio.github_repository

    return true if !show && !@portfolio.github_repository.changed?

    @portfolio.github_repository.check_repo_owner?(current_user)
  end

  def check_authority?
    @portfolio.user_id == current_user.id || (current_user.organizations.include? @portfolio.organization)
  end
end
