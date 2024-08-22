class Auth::LikesController < Auth::ApplicationController
  before_action :set_portfolio

  # POST /auth/portfolios/:portfolio_id/likes
  def create
    if @portfolio.likes.exists?(user: current_user)
      render json: { message: '既に「いいね」されています' }, status: :unprocessable_entity
    else
      @portfolio.likes.create!(user: current_user)
      render json: { message: '「いいね」しました' }, status: :created
    end
  end

  # DELETE /auth/portfolios/:portfolio_id/likes
  def destroy
    like = @portfolio.likes.find_by(user: current_user)

    if like
      like.destroy!
      render json: { message: '「いいね」を取り消しました' }, status: :ok
    else
      render json: { message: '「いいね」が見つかりません' }, status: :not_found
    end
  end

  private

  def set_portfolio
    @portfolio = Portfolio.find(params[:portfolio_id])
  end
end
