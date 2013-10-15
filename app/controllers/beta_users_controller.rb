class BetaUsersController < ApplicationController
  def create
	  @beta_user = BetaUser.new(params.require(:beta_user).permit(:email))

    respond_to do |format|
	    if @beta_user.save
        format.js
      else
	      format.js
	    end
    end
  end
end
