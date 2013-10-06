class Users::RegistrationsController < Devise::RegistrationsController
	before_action :sign_up_permitted_parameters, :only => [:create]
	before_action :account_update_permitted_parameters, :only => [:update]

  def new
    build_resource({})
    render 'users/signinup'
  end

  protected
    def after_sign_up_path_for(resource)
	    user = User.find(resource)
      user_profile_path(user.profile)
    end

    def sign_up_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :username
    end

    def account_update_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) << :username
    end
end