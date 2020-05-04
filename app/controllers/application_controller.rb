class ApplicationController < ActionController::Base
		before_action :authenticate_user!, :except => [:index]

     before_action :configure_permitted_parameters, if: :devise_controller?
     
     protected

          def configure_permitted_parameters
               devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :name, :phone_number, :organization_name,  :country, :zipcode, :organization_type)}

               devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :current_password, :name, :phone_number, :organization_name, :country, :zipcode, :organization_type)}
          end
end
