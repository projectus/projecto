class UserCollaborationInfoController < ApplicationController
	before_action :set_user
	
  def collaborations
  end

  # Owned projects
  def projects
	  @owned_projects = @user.owned_projects
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
