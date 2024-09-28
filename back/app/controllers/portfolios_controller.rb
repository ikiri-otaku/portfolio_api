class PortfoliosController < ApplicationController
  # GET    /portfolios/:id
  def show
    @portfolio = Portfolio.eager_load(:user, :organization, :pictures).find(params[:id])
    # TODO: 技術、画像、LIKE、View取得
    render status: :ok, json: @portfolio.to_api_response
  end

  # キーワード検索
  # GET    /portfolios/search
  def search
    portfolios = Portfolio.includes(:pictures).keyword_like(params[:query]).limit(30)
    render status: :ok, json: portfolios.map(&:to_api_response)
  end
end
