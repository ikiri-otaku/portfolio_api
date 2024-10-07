class Auth::LikesController < Auth::ApplicationController
  before_action :set_portfolio

  # POST /auth/portfolios/:portfolio_id/likes
  def create
    if @portfolio.likes.exists?(user: current_user)
      render json: status: :unprocessable_entity
    else
      @portfolio.likes.create!(user: current_user)
      render json: status: :created
    end
  end

  # DELETE /auth/portfolios/:portfolio_id/likes
  def destroy
    like = @portfolio.likes.find_by(user: current_user)

    if like
      like.destroy!
      render json: status: :ok
    else
      render json: status: :not_found
    end
  end

  private

  def set_portfolio
    @portfolio = Portfolio.find(params[:portfolio_id])
  end
end
