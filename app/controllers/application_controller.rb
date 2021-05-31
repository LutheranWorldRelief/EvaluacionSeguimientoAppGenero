class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :except => [:index]

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :name, :phone_number, :organization_name, :country, :zipcode, :organization_type) }

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :current_password, :name, :phone_number, :organization_name, :country, :zipcode, :organization_type) }
  end

  def find_survey(id)
    Survey.find(id)
  end

  # @param id [Integer]
  # @return [Diagnostic]
  def find_diagnostic (id)
    Diagnostic.find(id) rescue nil
  end

  # @param id [Integer]
  # @return [Diagnostic]
  def find_diagnostic_secure(id)

    diagnostic = find_diagnostic(id)

    if !current_user.is_admin and diagnostic.user_id != current_user.id
      exception_403_not_allowed ("No tiene permisos para ver este diagnóstico")
    end

    diagnostic
  end

  def find_user(email)
    User.where(email: email).last
  end

  def find_current_user
    User.find_by(id: session[:user_id])
  end

  def exception_403_not_allowed(message)
    render json:{ message: message}, status: :unauthorized and return
  end
end
