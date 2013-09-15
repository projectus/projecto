class UserProfilesController < ApplicationController
  before_action :set_user_profile, only: [:show, :edit, :update, :show_resume]
	before_action :authenticate_user!, except: [:index, :show, :show_resume]
  before_action :authenticate_current_user_as_profile_owner, except: [:index, :show, :show_resume] 
	
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
	  @contact = @user_profile.card
  end

  # PATCH/PUT /user_profiles/1
  # PATCH/PUT /user_profiles/1.json
  def update
	  unless params[:contact].nil?
		  permitted_fields = params.require(:contact).permit(:name, :email, :age, :location)
		  card = @user_profile.card
	    card.update(permitted_fields.symbolize_keys)
	    @user_profile.card_hash = card.inspect
	  end
    respond_to do |format|
      if @user_profile.save#update(user_profile_params)
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

    def associated_user
	    @user_profile.user
	  end
		
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_profile_params
      params.require(:user_profile).permit()
    end

    # Only let current user modify his own profile
    def authenticate_current_user_as_profile_owner
	    redirect_to @user_profile, alert: "This is not your profile!" unless current_user == associated_user
	  end
end
