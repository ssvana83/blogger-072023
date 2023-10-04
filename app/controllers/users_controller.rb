class UsersController < ApplicationController


  def create
    user = User.create!(user_params) #the bang implies that there is no need for an if/else conditional
    session[:user_id] = user.id
    render json: UserSerializer.new(user), status: :created
  end

  # the status isnt necessary but is good practice 

  def show
    return render json: {error: "Not authorized"}, status: :unauthorized unless session.include?(:user_id)
    user ||= User.find_by_id(session[:user_id])
    render json: UserSerializer.new(user), status: :ok
  end
  # this in charge of finding current user(if any) and happens at each page refresh
  # if session doesnt include user_id fronm first line, then fire next line
  # find user_id and user associated with it





  private

  def user_params
    params.permit(:username, :email, :password)
  end


end
