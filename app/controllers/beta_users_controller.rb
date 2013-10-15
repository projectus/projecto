class BetaUsersController < ApplicationController
  def create
	  @beta_user = BetaUser.new(params.require(:beta_user).permit(:email))
    @beta_user.save

    respond_to do |format|
	    if @beta_user.save
        format.js
      end
    end
  end
end
