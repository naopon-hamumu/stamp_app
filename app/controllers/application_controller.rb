class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    stamp_rallies_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def after_sign_up_path_for(resource)
    stamp_rallies_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
