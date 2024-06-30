class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  private

  def render_unprocessable_entity_response(exception)
    Rails.logger.info exception.record.errors.full_messages
    Rails.logger.info exception.inspect
    render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
