class UserProfilesController < ApplicationController
  before_action :set_user_profile, only: [:show, :edit, :update, :show_resume]
	before_action :authenticate_user!, except: [:index, :show, :show_resume]
  before_action :authenticate_current_user_as_profile_owner, except: [:index, :show, :show_resume] 

  helper_method :user, :profile
	
  # GET /user_profiles/1
  # GET /user_profiles/1.json
  def show
	  @contact = @user_profile.card
  end

  def show_resume
	  @resume = @user_profile.resume
	end
	
  # GET /user_profiles/1/edit
  def edit
  end

  # PATCH/PUT /user_profiles/1
  # PATCH/PUT /user_profiles/1.json
  def update
    respond_to do |format|
      if @user_profile.update(user_profile_params)
        format.html { redirect_to @user_profile, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_profile
      @user_profile = UserProfile.find(params[:id])
    end

    def user
	    @user_profile.user
	  end

    def profile
	    @user_profile
	  end
		
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_profile_params
      params.require(:user_profile).permit(:card, :resume)
    end

    # Only let current user modify his own profile
    def authenticate_current_user_as_profile_owner
	    redirect_to :back, alert: "This is not your profile!" unless current_user == user
	  end
end
