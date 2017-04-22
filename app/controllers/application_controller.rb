class ApplicationController < ActionController::Base
  before_action :configure_permitted_parametes, if: :devise_controller?
  protect_from_forgery with: :exception

  def require_is_admin
    if !current_user.admin?
      flash[:alert] = 'You are not admin'
      redirect_to root_path
    end
  end

  protected
  def configure_permitted_parametes
    devise_parameter_sanitizer.permit(:sign_up, keys: [:is_admin,:name])
  end


end
