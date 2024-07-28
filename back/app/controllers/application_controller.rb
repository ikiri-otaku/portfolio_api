class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from GithubClient::Error, with: :github_base_error

  private

  def render_unprocessable_entity_response(exception)
    Rails.logger.info exception.record.errors.full_messages
    Rails.logger.info exception.inspect
    render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def github_base_error(exception)
    Rails.logger.error exception.inspect
    render json: { error: exception.inspect }, status: :internal_server_error
  end
end
