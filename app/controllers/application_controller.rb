class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected
  def admin_required
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == 'admin' && password == 'password'
    end if Rails.env.development? || params[:admin_http]
  end
end
