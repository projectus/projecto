class UserProfilesController < ApplicationController
  before_action :set_user_profile
	before_action :authenticate_user!, only: [:update]
  before_action :authenticate_current_user_as_profile_owner, only: [:update] 
	
  # GET /user_profiles/1
  # GET /user_profiles/1.json
  def show
  end
	
  # GET /user_profiles/1/edit
  def edit
	  set_contact_info
	  @avatar_image = @user_profile.avatar
  end

  # PATCH/PUT /user_profiles/1
  # PATCH/PUT /user_profiles/1.json
  def update
    @user_profile.update_contact_card(permitted_fields)	

    set_contact_info
	
		# Update the user's avatar with the gallery image
	  image_id = params[:avatar][:image_id]
	  unless image_id.empty?
	    gi = GalleryImage.find(image_id)
	    @user_profile.avatar.update_image(gi)
    end
	
    respond_to do |format|
      if @user_profile.save
        format.html { redirect_to @user_profile, notice: 'Profile was successfully updated.' }
      else
        format.html { render action: 'edit' }
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

    def set_contact_info
		  @contact = @user_profile.card		
		  @name = @contact[:name].nil? ? ['','',''] : @contact[:name].split(',')		  
	  end
	
    def permitted_fields
		  pf = params.require(:contact)
		  pf[:name] = pf[:name].values.join(',')
		  pf[:birthday] = pf[:birthday].values.join(',')
		  pf.permit(:secondary_email, :location, :birthday, :name)
	  end

    # Only let current user modify his own profile
    def authenticate_current_user_as_profile_owner
	    redirect_to @user_profile, alert: "This is not your profile!" unless current_user == associated_user
	  end
end
