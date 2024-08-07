# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
  
    def configure_sign_up_params
        devise_parameter_sanitizer.permit(:sign_up, keys: [
          :first_name, :last_name, addresses_attributes: [
            :street, :city, :province_id, :postal_code, :country
          ]
        ])
      end
    def new
        build_resource({})
        resource.addresses.build
        respond_with resource
      end
  
    protected
  
    def after_sign_up_path_for(resource)
      root_path
    end
  end
  