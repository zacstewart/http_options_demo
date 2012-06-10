class ApplicationController < ActionController::Base
  protect_from_forgery
  USERNAME = 'admin'.freeze
  PASSWORD = 'secret'.freeze

  def authenticated?
    request.authorization.present?
  end

  protected
  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      username == USERNAME && password == PASSWORD
    end
  end
end
