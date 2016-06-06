class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_response(data)
    payload = {}
    begin
      payload[:error] = 0
      payload[:data] = data
    rescue => e
      payload[:error] = 1
      payload[:message] = e.message
    end
    render json: payload
  end
end
