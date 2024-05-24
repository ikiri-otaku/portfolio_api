class Auth::UsersController < Auth::ApplicationController
  def create
    user = User.new(user_params)
    return render status: :ok if User.exists?(auth0_id: user.auth0_id)

    user.save!
    render status: :ok
  end

  # TODO: 退会
  def destroy; end

  private

  def user_params
    params.require(:user).permit(:name, :github_username, :auth0_id)
  end
end
