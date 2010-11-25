class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def authenticate
    authenticate_or_request_with_http_basic("Administration") do |login, password|
      login == 'admin' && password == 'password'
    end
  end
end
