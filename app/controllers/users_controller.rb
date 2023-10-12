class UsersController < ApplicationController
# skip_before_action :authorized!, only: [:create]

  def create
    user = User.create!(user_params) #the bang implies that there is no need for an if/else conditional
    session[:user_id] = user.id
    render json: user, status: :created
  end

  # the status isnt necessary but is good practice 

  # show route is refactored here with changes made to application controller 
  def show
    # return render json: {error: "Not authorized"}, status: :unauthorized unless session.include?(:user_id)
    # moved this since its already in application controller
    # user ||= User.find_by_id(session[:user_id])
    # this line not needed since running authorized up top which runs current user
    render json: @current_user, status: :ok
  end
  # this in charge of finding current user(if any) and happens at each page refresh
  # if session doesnt include user_id fronm first line, then fire next line
  # find user_id and user associated with it





  private

  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
  end


end
