class PortfoliosController < ApplicationController
  # GET    /portfolios/:id
  def show
    @portfolio = Portfolio.eager_load(:user, :organization).find(params[:id])
    # TODO: 技術、画像、LIKE、View取得
    render status: :ok, json: @portfolio.to_api_response
  end
end
