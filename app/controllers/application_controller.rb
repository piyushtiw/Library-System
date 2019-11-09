class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers

  before_action :authenticate_user!

  include Pundit
  protect_from_forgery
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :user_type, :library_id, :university_id, :education_level])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :user_type, :library_id, :university_id, :education_level])
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || root_path
  end

  private

  def user_not_authorized
    redirect_path = request.referer.present? ? request.referer : "/"
    flash[:notice] = "Access Denied"
    redirect_to redirect_path
  end
end
