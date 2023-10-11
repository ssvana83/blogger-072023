class ApplicationController < ActionController::API
#   include ActionController::Serialization 
  # so that in API mode it is told more about how to execute 
  include ActionController::Cookies 
  rescue_from ActiveRecord::RecordNotFound, with: :no_route
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
#   before_action :authorized! #will try to run on every action of every controller

  wrap_parameters format: [] #to prevent nested object in params
#  Rails will automatically try to package your parameters
#  within the resource thats been generated. Dont want this duplicated so this macro can be used so object and object/data
#  are both created


  private

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    # this is to find who the current user is
    # ||= (memoization). Minimizes how many times it needs to go into the database. if not used 
    #  the problem is it invokes .find multiple times.

    def authorized!
        no_route unless current_user
    end

    def invalid_record(invalid)
        render json: {error: invalid.record.errors.full_messages.to_sentence}, status: :unprocessable_entity
    end

    # def no_route
    #     render json: {error: "Not authorized"}, status: :unauthorized unless session.include?(:user_id)
    # end
    def no_route
        render json: {error: "Not authorized"}, status: :unauthorized unless session.include?(:user_id)
    end

end

