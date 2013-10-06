class ResumeEntriesController < ApplicationController
	before_action :authenticate_user!
  before_action :set_user_profile
	before_action :authenticate_current_user_as_profile_owner

  def new
	  @section = params[:section].to_sym
	  @resume = @user_profile.resume
	  max_key = @resume[@section].keys.max
	  @key = max_key.nil? ? 'entry_01' : max_key.succ
	  @entry = UserProfile.empty_resume_entry(@section)
	end
	
  # GET /project_profiles/1/edit
  def edit
	  @key = params[:key].to_sym
	  @section = params[:section].to_sym
	  @resume = @user_profile.resume
	  @entry = @resume[@section][@key]
  end

  # PATCH/PUT /project_profiles/1
  # PATCH/PUT /project_profiles/1.json
  def update
	  @key = params[:key].to_sym
	  @section = params[:section].to_sym
	 
	  unless params[:entry].nil?
		  @user_profile.update_resume_entry(@section,@key,permitted_fields)
		end

	  @resume = @user_profile.resume
		
    respond_to do |format|
      if @user_profile.save
        format.html { redirect_to edit_resume_url(@user_profile), notice: 'User profile was successfully updated.' }
        format.json { head :no_content }
      else
			  @entry = @resume[@section][@key]
        format.html { render action: 'edit' }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
	  key = params[:key]
	  section = params[:section]
	  @user_profile.delete_resume_entry(section,key)
    respond_to do |format|
      format.html { redirect_to edit_resume_url(@user_profile) }
      format.json { head :no_content }
    end
  end
	
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_profile
      @user_profile = UserProfile.find(params[:id])
    end

    def permitted_fields
	    pf = params.require(:entry)
	    if @section == :experience || @section == :education
		    pf[:start_date] = pf[:start_date].values.join(',')
		    pf[:end_date] = pf[:end_date].values.join(',')
		  end
	    if @section == :experience
		    pf.permit(:title, :location, :description, :start_date, :end_date)
		  elsif @section == :education
			  pf.permit(:school, :location, :field, :degree, :description, :start_date, :end_date)
		  elsif @section == :skills
			  pf.permit(:title)
		  end
	  end
	
    def associated_user
	    @user_profile.user
	  end
	
	  # Only let current user modify his own profile
    def authenticate_current_user_as_profile_owner
	    redirect_to @user_profile, alert: "This is not your profile!" unless current_user == associated_user
	  end
end
