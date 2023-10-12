class SessionsController < ApplicationController
  # skip_before_action :authorized!, only: [:create]

  def create
    # find_by email means we have to resucue with if/else condition. If user&.(if user isnt falsey)
    # if user isnt nil or falsey then invoke .authenticate method in it
    
    user = User.find_by(email: params[:email])
  
    if user&.authenticate(params[:password])
      session[:user_id] = user.id #this line is responsible for signing someone in. store unique info about user in session
      render json: user, status: :accepted
      # ???? should I change the line above to; render json: user, status: :created???
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

  # why are my params being blocked?
  # <ActionController::Parameters {"controller"=>"sessions", "action"=>"create"} permitted: false>
  # chanhged line 7 from User.find_by(parms[:email]) to (session_params)

end
