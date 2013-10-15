class BetaUsersController < ApplicationController
  def create
	  @beta_user = BetaUser.new(params.require(:beta_users).permit(:email))
    @beta_user.save

    respond_to do |format|
      format.js
    end
  end
end
