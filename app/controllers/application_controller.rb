class ApplicationController < ActionController::API
  include ActionController::Serialization 
  # so that in AI mode it is told more about how to execute 
  include ActionController::Cookies 
  rescue_from ActiveRecord::RecordNotFound, with: :no_route
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
  before_action :authorized!

  private

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def authorized!
        no_route unless current_user
    end

    def invalid_record(invalid)
        render json: {error: invalid.record.errors.full_messages.to_sentence}, status: :unprocessable_entity
    end

    def no_route
        render json: {error: "Not authorized"}, status: :unauthorized unless session.include?(:user_id)
    end

end

