class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Authorized auth fields
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
        :firstname, :lastname
    ])
  end

end
