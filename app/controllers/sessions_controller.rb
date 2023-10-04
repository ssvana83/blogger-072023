class SessionsController < ApplicationController

  def create
    # find_by email means we have to resucue with if/else condition. If user&.(if user isnt falsey)
    # if user isnt nil or falsey then invoke .authenticate method in it
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id #this line is responsible for signing someone in. store unique info about user in session
      render json: UserSerializer.new(user), status: :accepted
    else
      render json: {error: "Not authorized"}, status: :unauthorized
    end
  end

  def destroy
    session.delete(:user_id)
    headers :no_content
  end

end
