class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :login])
  end

  def authorize_admin
    return unless !current_user.admin?
    redirect_to root_path, alert: I18n.t('errors.messages.access_denied') 
  end
end
