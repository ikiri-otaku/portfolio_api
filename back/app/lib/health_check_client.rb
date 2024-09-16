require 'net/http'
require 'uri'

class HealthCheckClient
  def initialize(portfolio)
    @portfolio = portfolio
  end

  def check?
    uri = URI.parse(@portfolio.url)
    response = Net::HTTP.get_response(uri)
    response.is_a?(Net::HTTPSuccess)
  rescue StandardError => e
    Rails.logger.info "HealthCheckClientFailed. portfolio_id: #{@portfolio.id}, #{e.inspect}"
    false
  end
end
