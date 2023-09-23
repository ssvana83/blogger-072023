class UsersController < ApplicationController


  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    render json: UserSerializer.new(user), status: :created
  end

  def show
    return render json: {error: "Not authorized"}, status: :unauthorized unless session(:user_id)
    user ||= User.find_by_id(session[:user_id])
    render json: UserSerializer.new(user), status: :ok
  end




  private

  def user_params
    params.permit(:username, :email, :password)
  end


end
