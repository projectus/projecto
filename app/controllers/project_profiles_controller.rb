class ProjectProfilesController < ApplicationController
	before_action :authenticate_user!, except: [:details, :show]	
  before_action :set_project_profile
	before_action(except: [:details, :show]) do
	  authenticate_current_user_as_project_owner(associated_project, 
	                       "You don't have the permissions to modify this project.")
	end	
  before_action :set_project_details, only: [:new, :details, :edit]

  ## TODO: THIS HAS TO CHANGE. NEW CONTROLLER FOR DETAILS ##

  # GET /project_profiles/1
  # GET /project_profiles/1.json
  def show
	  redirect_to project_details_url(associated_project)
  end
	
	def details
  end

  def new
	  @key = @details.keys.max.succ
	  @entry = ProjectProfile.empty_details_entry_hash(@key)
	  render action: 'edit'
	end
	
  # GET /project_profiles/1/edit
  def edit
  end

  # PATCH/PUT /project_profiles/1
  # PATCH/PUT /project_profiles/1.json
  def update
	  unless params[:entry].nil?
      update_details      
	  end
	
    respond_to do |format|
      if @project_profile.save#update(project_profile_params)
        format.html { redirect_to edit_project_profile_url(@project_profile), notice: 'Project profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
	  key = params[:key]
	  @project_profile.delete_details_entry(key)
    respond_to do |format|
      format.html { redirect_to project_details_url(associated_project) }
      format.json { head :no_content }
    end
  end
	
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_profile
      @project_profile = ProjectProfile.find(params[:id])
    end

    def set_project_details
		  @details = @project_profile.details
	  end
	
    def update_details
		  permitted_fields = params.require(:entry).permit(:title, :content)
		  key = params[:key]
		  @project_profile.update_details_entry(key,permitted_fields)
	  end

    def associated_project
	    @project_profile.project
	  end
end
