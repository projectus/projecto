class UserCollaborationInfoController < ApplicationController
	before_action :set_user_and_profile
	
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
    def set_user_and_profile
      @user = User.find(params[:id])
      @user_profile = @user.user_profile
    end
end
