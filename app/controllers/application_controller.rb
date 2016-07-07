class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.new_user_session_path, alert: exception.message
  end

  def after_sign_in_path_for user
    profile_path
  end

  protected
  def authenticate_user!
    if user_signed_in?
      super
    else
      flash[:modal] = 'signInModal'
      flash[:notice] = 'Неверный логин или пароль'
      redirect_to root_path
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end
end
