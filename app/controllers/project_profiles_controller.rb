class ProjectProfilesController < ApplicationController
	before_action :authenticate_user!, except: [:details, :show]	
  before_action :set_project_profile
	before_action(except: [:details, :show]) do
	  authenticate_current_user_as_project_owner(associated_project, 
	                       "You don't have the permissions to modify this project.")
	end	
  before_action :set_project_details, only: [:details, :edit]

  # GET /project_profiles/1
  # GET /project_profiles/1.json
  def show
	  redirect_to project_details_url(associated_project)
  end
	
	def details
  end
	
  # GET /project_profiles/1/edit
  def edit
  end
	
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_profile
      @project_profile = ProjectProfile.find(params[:id])
    end

    def set_project_details
		  @details = @project_profile.details
	  end

    def associated_project
	    @project_profile.project
	  end
end
