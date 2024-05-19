class Auth::TestMessagesController < Auth::ApplicationController
  def admin
    render json: 'This is a admin message.'
  end

  def protected
    render json: 'This is a protected message.'
  end

  def public
    render json: 'This is a public message.'
  end
end
