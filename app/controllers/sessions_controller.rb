class SessionsController < ApplicationController
  skip_before_action :authorized!, only: [:create]

  def create
    user = User.find_by(email: params[:email])
  
    if user&.authenticate(params[:password])
      session[:user_id] = user.id #this line is responsible for signing someone in. store unique info about user in session
      render json: user, status: :accepted
    else
      render json: {error: "Not authorized"}, status: :unauthorized
    end
  end

  def destroy
    session.delete(:user_id)
    head :no_content
  end


  private

  def session_params
    params.permit(:email, :password)
  end


end
