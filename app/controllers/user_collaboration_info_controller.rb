class UserCollaborationInfoController < ApplicationController
	before_action :set_user

  helper_method :user, :profile
	
  def collaborations
  end

  def applications
  end

  def invitations
  end

  # Owned projects
  def projects
	end
	
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user
	    @user
	  end
	
	  def profile
		  @user.user_profile
		end
end
