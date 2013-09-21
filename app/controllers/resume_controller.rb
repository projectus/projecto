class ResumeController < ApplicationController
  before_action :set_user_profile
  before_action :set_user_resume
	
  # GET /user_profiles/1
  # GET /user_profiles/1.json
  def show
  end
	
  # GET /user_profiles/1/edit
  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_profile
      @user_profile = UserProfile.find(params[:id])
    end

    def set_user_resume
	    @resume = @user_profile.resume
	  end
		
    def associated_user
	    @user_profile.user
	  end
end
