class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.new_user_session_path, alert: exception.message
  end

  def testcheck
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def testpay
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end
end
