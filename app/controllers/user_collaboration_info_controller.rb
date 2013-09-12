class UserCollaborationInfoController < ApplicationController
	before_action :set_user

  helper_method :associated_user
	
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

    def associated_user
	    @user
	  end
end
