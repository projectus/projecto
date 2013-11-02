class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_action do redirect_to landing_path unless landing? end
	
  helper_method :associated_project, :associated_user, :landing?

  protected
  # Authenticate the signed in user as the project owner
    def authenticate_current_user_as_project_owner(project, message)
	    unless project.owned_by?(current_user)
	      redirect_to :back, alert: message
	    end
	  end
	
	  def landing?
		  return params[:action]=='landing' || params[:action]=='about' || params[:controller]=='beta_users'
		end
end
