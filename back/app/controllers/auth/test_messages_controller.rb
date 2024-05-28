class Auth::TestMessagesController < Auth::ApplicationController
  def admin
    render json: 'This is a admin message.'.to_json
  end

  def protected
    render json: 'This is a protected message.'.to_json
  end

  def public
    render json: 'This is a public message.'.to_json
  end
end
