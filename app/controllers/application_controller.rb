class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_team_and_player, unless: :devise_controller?
  include ApplicationHelper
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name login])
  end

  def authorize_admin
    return if current_user.admin?
    redirect_to root_path, alert: I18n.t('errors.messages.access_denied')
  end

  def check_team_and_player
    return if !before_first_game? || current_user.picked_tops?
    redirect_to edit_user_path(current_user)
  end

  def authorize_current_user
    return if current_user.id.to_s == params[:id]
    redirect_to root_path, alert: I18n.t('errors.messages.access_denied')
  end
end
