class UserRequestInfoController < ApplicationController
	before_action :set_user

  def applications
  end

  def invitations
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end
