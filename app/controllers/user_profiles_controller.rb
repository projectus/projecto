class UserProfilesController < ApplicationController
  before_action :set_user_profile, only: [:show, :edit, :update, :show_resume]
	before_action :authenticate_user!, except: [:show, :show_resume]
  before_action :authenticate_current_user_as_profile_owner, except: [:show, :show_resume] 
	
  # GET /user_profiles/1
  # GET /user_profiles/1.json
  def show
  end

  def show_resume
	  @resume = @user_profile.resume
	end
	
  # GET /user_profiles/1/edit
  def edit
	  @contact = @user_profile.card
	  if @contact[:name].nil?
		  @name = ['','','']
		else
	    @name = @contact[:name].split(',')
	  end
	  if @contact[:birthday].nil?
		  @birthday = [1900,1,1]
		else
	    @birthday = @contact[:birthday].split(',')
    end
  end

  # PATCH/PUT /user_profiles/1
  # PATCH/PUT /user_profiles/1.json
  def update
	  unless params[:contact].nil?
      update_contact_card      
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

    def set_user_contact
	    @contact = @user_profile.card
	  end
	
    def associated_user
	    @user_profile.user
	  end

    def update_contact_card
		  permitted_fields = params.require(:contact).permit(:secondary_email, :location)
		  permitted_fields[:name] = params[:contact][:name].values.join(',')
		  permitted_fields[:birthday] = params[:contact][:birthday].values.join(',')
      @user_profile.update_contact_card(permitted_fields)	
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
